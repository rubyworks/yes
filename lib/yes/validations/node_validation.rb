module YES

  #
  class NodeValidation < AbstractValidation

    #
    def initialize(spec, node)
      @spec = spec
      @node = node
    end

    #
    attr :spec

    #
    attr :node

    # Get the applicable node's tag.
    def tag
      node.type_id
    end

    # Get the applicable node's value.
    def value
      node.value
    end

  end

end

