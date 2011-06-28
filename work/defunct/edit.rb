class YES

  #
  class Edit

    #
    attr :validator

    #
    def initialize(validation)
      @validation = validation
    end

    #
    def edit
      validator.name.split('::').last.chomp('Validation').downcase
    end

    #
    def spec
      validator.spec
    end

    #
    def node
      validator.node
    end

    #
    def tag
      node.type_id
    end

    #
    def value
      node.value
    end

    # Covert a YAML node (Syck) node into a generic representation.
    #
    # TODO: Should `style` be part of this? Also, is `kind` the proper term?
    def catholic_node
      n = {}
      n['tag']   = node.type_id 
      #n['type'] = #base_type_id(node)
      n['kind']  = node.kind.to_s
      n['value'] = node.value
      n['style'] = node.instance_variable_get('@style').to_s
      n
    end

    #
    def to_h
      return 'edit' => edit,
             'spec' => spec,
             'node' => catholic_node
    end

    # FIXME: this is quite right
    def to_yaml(opts={})
      YAML.quick_emit(nil, opts) do |out|
        out.scalar(taguri, to_h, :plain)
      end
    end

  end

end
