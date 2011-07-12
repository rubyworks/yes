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
      @schema    = YAML.load(schema)
      @checklist = []
    end

    #
    def validate(yaml)
      @tree      = YAML.parse(yaml)
      @checklist = []

      @schema.each do |ypath, spec|
        validate_ypath(ypath, spec)
      end

      @checklist.reject{ |v| v.valid? }
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
      nodes = select_nodes(ypath)

      YES.constraints.each do |c|
        @checklist.concat(
          c.checklist(spec, tree, nodes)
        )
      end
    end

    #
    def select_nodes(ypath)
      case ypath
      when Hash
        nodes = []
        tree.select('*') # all nodes
        YES.validators.each do |c|
          next unless Constraints::NodeConstraint === c
          applicable = c.validate(ypath, spec, tree, nodes)
          selection  = applicable.select{ |v| v.valid? }
          nodes.concat(selection.map{ |s| s.node })
        end
        nodes
      else
        tree.select(ypath)
      end
    end

    ## Validate if a node is the only one of it's value in a sequence
    ## or mapping.
    #def validate_unique(spec, nodes)
    #  return unless unique = spec['unique']
    #  # TODO: how to do?
    #end

  end

end
