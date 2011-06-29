module YES

  #
  class NodeValidation < AbstractValidation

    #
    def initialize(ypath, spec, tree, node)
      super(ypath, spec, tree)
      @node = node
    end

  public

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

