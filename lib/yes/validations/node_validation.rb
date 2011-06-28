module YES

  #
  class NodeValidation < AbstractValidation

    #
    attr :spec

    #
    attr :node

    #
    def initialize(spec, node)
      @spec = spec
      @node = node
    end

  end

end

