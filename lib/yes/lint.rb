module YES

  # YAML Easy Schema - Constrain Validator ("Lint")
  #
  # Issues
  #
  # * Matching fully-quaified tags.
  # * Handling namespaces.
  # * Handling YAML version directive.
  #
  class Lint

    # The schema document.
    attr :schema

    # The tree, which is populate when #validate is called.
    #attr :tree

    # The constraint checklist.
    attr :checklist

    #
    def initialize(schema)
      @schema    = YAML.load(schema)
      @checklist = []
    end

    #
    # @param [String] yaml
    #   A YAML document.
    #
    # @return [Array]
    #   List of constraints that were invalid.
    #
    def validate(yaml)
      @checklist = []

      tree = YAML.parse(yaml)

      @schema.each do |ypath, spec|
        validate_ypath(ypath, spec, tree)
      end

      @checklist.reject{ |v| v.valid? }
    end

    #
    def validate_ypath(ypath, spec, tree)
      validate_spec(ypath, spec, tree)

      ## handle sub-paths
      if spec['map']
        spec['map'].each do |sub_path, sub_spec|
          sub_ypath = ypath + '/' + sub_path
          validate_ypath(sub_ypath, sub_spec, tree)
        end
      end
    end

    # Process all validations.
    #
    # FIXME: Add logic handling.
    def validate_spec(ypath, spec, tree)
      nodes = select_nodes(ypath, tree)

      YES.constraints.each do |c|
        @checklist.concat(c.checklist(spec, tree, nodes))
      end
    end

    # TODO: Maybe this should be a class method, too ?
    def select_nodes(ypath, tree)
      case ypath
      when Hash
        if path = ypath['path'] || ypath['ypath']
          nodes = tree.select(path)
        else
          nodes = tree.select('*') # all nodes
        end
        YES.constraints.each do |c|
          next unless Constraints::NodeConstraint === c
          checklist = c.checklist(spec, tree, nodes)
          selection = checklist.select{ |v| v.valid? }
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
