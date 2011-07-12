module YES

  module Constraints

    # The NodeValidation class is an abstract class
    # and used for create validation subclasses that
    # apply constraints on a sigle node.
    #
    class NodeConstraint < AbstractConstraint

      # Like {AbstractValidation#initialize} but takes a `node` qas well.
      def initialize(spec, tree, node)
        super(spec, tree, [node])
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

#    # Covert a YAML node (Syck) node into a generic representation.
#    #
#    # TODO: Should `style` be part of this? Also, is `kind` the proper term?
#    def catholic_node(node)
#      n = {}
#      n['tag']   = node.type_id 
#      #n['type'] = #base_type_id(node)
#      n['kind']  = node.kind.to_s
#      n['value'] = node.value
#      n['style'] = node.instance_variable_get('@style').to_s
#      n
#    end

    end

  end

end
