module YES

  class TreeValidation < AbstractValidation

    #
    def initialize(ypath, spec, tree, nodes)
      super(ypath, spec, tree)
      @nodes = nodes
    end

  public

    #
    attr :nodes

  end

end
