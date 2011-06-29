module YES

  # YAML Easy Schema
  #
  # Issues
  #
  # * Matching fully-quaified tags.
  # * Handling namespaces.
  # * Handling YAML version directive.
  #
  class Lint

    #
    attr :schema

    #
    attr :tree

    #
    attr :validations

    #
    def initialize(schema)
      @schema = YAML.load(schema)
      @validations = []
    end

    #
    def validate(yaml)
      @tree = YAML.parse(yaml)
      @validations = []

      @schema.each do |ypath, spec|
        validate_ypath(ypath, spec)
      end

      @validations.reject{ |v| v.valid? }
    end

    #
    def validate_ypath(ypath, spec)
      validate_spec(ypath, spec)

      # TODO: how to handle sub-paths?
      spec.each do |r, s|
        if r[0,1] =~ /\W/
          rel_ypath = ypath + r
          rel_spec  = s
          validate_ypath(rel_ypath, rel_spec)
        end
      end
    end

    # Process all validations.
    def validate_spec(ypath, spec)
      nodes = @tree.select(ypath)

      validate_type      ypath, spec, nodes
      validate_tag       ypath, spec, nodes
      validate_requires  ypath, spec, nodes
      validate_exclusive ypath, spec, nodes
      validate_count     ypath, spec, nodes
      validate_length    ypath, spec, nodes
      validate_range     ypath, spec, nodes
      validate_regexp    ypath, spec, nodes
      validate_fnmatch   ypath, spec, nodes
      #validate_pattern   ypath, spec, nodes
    end

    # Validate the <i>tag type</i>. This ensure all the matching nodes
    # have the same base type specified. The tag type is the portion
    # of the tag the occcurs after the last non-alphanumeric character,
    # usually a `:`. In essence the tag type is the tag regardless of namespace.
    # 
    # Also, `#` is treated specially as a subset fo they type, so it will
    # be used if given in the type comparison.
    #
    # @example
    #   'foo' =~ '!!foo'
    #   'foo' =~ '!<tag:foo.org/bar:foo>'
    #   'foo' =~ '!<tag:foo.org/bar:foo>'
    #   'foo' =~ '!!foo#alt'
    #   'foo#alt' =~ '!!foo#alt'
    #
    def validate_type(ypath, spec, nodes)
      return unless TypeValidation.applicable?(spec)
      nodes.each do |node|
        @validations << TypeValidation.new(ypath, spec, tree, node)
      end
    end  

    # Validate the tag. This ensure all the matching nodes have the given tag.
    # Be sure to used quotes when starting the tag with `!`.
    #
    # NOTE: the tag should honer %TAG directives in the document, but as of 
    # yet this is not supported. Thus fully qualified tags need to be used
    # for anything beyond default !! and ! tags.
    def validate_tag(ypath, spec, nodes)
      return unless TagValidation.applicable?(spec)
      nodes.each do |node|
        @validations << TagValidation.new(ypath, spec, tree, node)
      end
    end

#    # Validates whether a matching node must be present within it's parent.
#    def validate_required(ypath, spec, nodes)
#      return unless RequiredValidation.applicable?(spec)
#      @validations << RequiredValidation.new(spec, nodes, tree)
#    end

    # Validates whether a matching node must be present within it's parent.
    def validate_requires(ypath, spec, nodes)
      return unless RequiresValidation.applicable?(spec)
      nodes.each do |node|
        @validations << RequiresValidation.new(ypath, spec, tree, node)
      end
    end

    # Validate inclusion - This can either be a boolean expression in
    # which case it validates that there is at least one matching
    # node. Otherwise, the value is taken to be a ypath and validates
    # that there are matching paths if the main selection is present.
    def validate_inclusive(ypath, spec, nodes)
      return unless InclusiveValidation.applicable?(spec)
      @validations << InclusiveValidation.new(ypath, spec, tree, nodes)
    end

    # Validate exclusion - This can either be a boolean expression in
    # which case it validates that there is no more than one matching
    # node. Otherwise, the value is taken to be a ypath and validates
    # that there are no matching paths if the main selection is present.
    def validate_exclusive(ypath, spec, nodes)
      return unless ExclusiveValidation.applicable?(spec)
      @validations << ExclusiveValidation.new(ypath, spec, tree, nodes)
    end

    # Validate count ensure there is a minimum and/or maximum
    # number of matching nodes.
    def validate_count(ypath, spec, nodes)
      return unless CountValidation.applicable?(spec)
      @validations << CountValidation.new(ypath, spec, tree, nodes)
    end

    ## Validate if a node is the only one of it's value in a sequence
    ## or mapping.
    #def validate_unique(spec, nodes)
    #  return unless unique = spec['unique']
    #  # TODO: how to do?
    #end

    # Validate if a node value is within a certain length.
    # The value is converted to a string using #to_s for the
    # comparison.
    def validate_length(ypath, spec, nodes)
      return unless LengthValidation.applicable?(spec)
      nodes.each do |node|
        @validations << LengthValidation.new(ypath, spec, tree, node)
      end
    end

    # Validate if a node is the only one of it's value in a sequence
    # or mapping.
    def validate_range(ypath, spec, nodes)
      return unless RangeValidation.applicable?(spec)
      nodes.each do |node|
        @validations << RangeValidation.new(ypath, spec, tree, node)
      end
    end

    # Validate that a node's value is amoung a provided
    # list of values.
    def validate_value(ypath, spec, nodes)
    end

    # Validate matching values against a regular expression.
    # All values are converted to strings (using #to_s) for comparison.
    def validate_regexp(ypath, spec, nodes)
      return unless RegexpValidation.applicable?(spec)
      nodes.each do |node|
        @validations << RegexpValidation.new(ypath, spec, tree, node)
      end
    end

    # Validate file glob match. This uess standard unix-style file matching,
    # primarily '*` and `?`, to detrmine a mathing node value.
    # All values are converted to strings (using #to_s) for comparison.
    def validate_fnmatch(ypath, spec, nodes)
      return unless FnmatchValidation.applicable?(spec)
      nodes.each do |node|
        @validations << FnmatchValidation.new(ypath, spec, tree, node)
      end
    end

    # -- support methods --------------------------------------------------------

    # Covert a YAML node (Syck) node into a generic representation.
    #
    # TODO: Should `style` be part of this? Also, is `kind` the proper term?
    def catholic_node(node)
      n = {}
      n['tag']   = node.type_id 
      #n['type'] = #base_type_id(node)
      n['kind']  = node.kind.to_s
      n['value'] = node.value
      n['style'] = node.instance_variable_get('@style').to_s
      n
    end

    # @param range [Array, String]
    #   The range representation.
    #
    # @example
    #   [1,1] =~ 1
    #   [1,2) =~ 1
    #   (1,2] =~ 2
    #   (1,3) =~ 2
    #
    def match_range(range, value)
      case range
      when Array  # array can do string comparisons
        value > range.first && value < range.last
      when /^(.*)\.\.\.(n|N)$/
        value >= $1.to_f
      when /^(.*)\.\.(n|N)$/
        value >= $1.to_f
      when /^(.*)\.\.\.(.*)$/
        value >= $1.to_f && value > $3.to_f
      when /^(.*)\.\.(.*)$/
        value >= $1.to_f && value >= $3.to_f
      when /^\[(.*)\,(.*)\]$/
        value >= $1.to_f && value >= $2.to_f
      when /^\[(.*)\,(.*)\)$/
        value >= $1.to_f && value > $2.to_f
      when /^\((.*)\,(.*)\]$/
        value > $1.to_f && value > $2.to_f
      when /^\((.*)\,(.*)\)$/
        value > $1.to_f && value > $2.to_f
      end
    end

  end

end
