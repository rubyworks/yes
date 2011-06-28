module YES

  class TreeValidation < AbstractValidation

    # 
    attr :spec

    #
    attr :nodes

    #
    attr :tree

    #
    def initialize(spec, nodes, tree)
      @spec  = spec
      @nodes = nodes
      @tree  = tree
    end

  end

end
