module YES

  # Validate that a node has specific tag.
  #
  class TagValidation < NodeValidation

    # Validate the tag. This ensure all the matching nodes have the given tag.
    # Be sure to used quotes when starting the tag with `!`.
    #
    # NOTE: the tag should honer %TAG directives in the document, but as of 
    # yet this is not supported. Thus fully qualified tags need to be used
    # for anything beyond default !! and ! tags.
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
      spec['tag']
    end

    #
    # @return [Boolean] validity
    def valid?
      return true unless applicable?
      spec['tag'] == (node.type_id || node.kind).to_s
    end

  end

end
