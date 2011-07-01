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
      #spec.each do |r, s|
      #  if r[0,1] =~ /\W/
      #    rel_ypath = ypath + r
      #    rel_spec  = s
      #    validate_ypath(rel_ypath, rel_spec)
      #  end
      #end
    end

    # Process all validations.
    #
    # FIXME: Add logic handling.
    def validate_spec(ypath, spec)
      nodes = @tree.select(ypath)

      YES.validators.each do |validator|
        @validations.concat(
          validator.validate(ypath, spec, tree, nodes)
        )
      end
    end

    ## Validate if a node is the only one of it's value in a sequence
    ## or mapping.
    #def validate_unique(spec, nodes)
    #  return unless unique = spec['unique']
    #  # TODO: how to do?
    #end

=begin
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
=end

  end

end
