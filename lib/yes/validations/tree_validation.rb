module YES

  # The TreeValidation class is an abstract class
  # and used for create validation subclasses than
  # needs access to the complete list of matching nodes.
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
