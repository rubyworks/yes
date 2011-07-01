module YES

  #
  class TypeValidation < NodeValidation

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
    # @return [Array<Validaiton>]
    def self.validate(ypath, spec, tree, nodes)
      return [] unless applicable?(spec)
      nodes.map do |node|
        new(ypath, spec, tree, node)
      end
    end  

    #
    def self.applicable?(spec)
      spec['type']
    end

    #
    def valid?
      return true unless applicable?
      type_match(node, spec['type'])
    end

    private

    # Get the nodes base type see if matches the given type.
    # The {TYPE_MATCH} chart is used to map a node base types
    # to a given type.
    #
    # @return [Boolean] node's type matches given type
    def type_match(node, type)
      node_type, node_subtype = base_type_id(node).split('#')
      want_type, want_subtype = type.split('#')

      return false if want_subtype && want_subtype != node_subtype

      pick_type = TYPE_MATCH[want_type] || [want_type]
      pick_type.any?{ |t| t == node_type }
    end

    # Get the base of the node's type tag, i.e. the part after the last
    # non-alphanumeric characeter plus `#`.
    #
    # @return [String] base type
    def base_type_id(node)
      fixed_type_id(node).split(/[^#A-Za-z0-9_-]/).last
    end

    # Return the `type_id` of a node. If the type_id is `nil` then
    # returns the `kind`.
    #
    # @return [String] type_id or kind of node
    def fixed_type_id(node)
      type_id = node.type_id
      if type_id
        type_id
      else
        node.kind.to_s
      end
    end

    #
    TYPE_MATCH = {
      'date'   => ['timestamp'],
      'bool'   => ['bool'],
      'number' => ['int', 'float']
    }

  end

end
