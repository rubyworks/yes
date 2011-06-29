module YES

  # The NodeValidation class is an abstract class
  # and used for create validation subclasses that
  # apply constraints on a sigle node.
  class NodeValidation < AbstractValidation

    # Like {AbstractValidation#initialize} but takes a `node` qas well.
    def initialize(ypath, spec, tree, node)
      super(ypath, spec, tree)
      @node = node
    end

  public

    # YAML Node.
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

