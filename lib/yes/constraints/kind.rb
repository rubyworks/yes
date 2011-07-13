module YES

  module Constraints

    # Validate the <i>kind of node</i>. There are only three kinds
    # of nodes: `scalar`, `map` and `seq`.
    # 
    class Kind < NodeConstraint

      #
      # @return [Array<Constraint>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)
        nodes.map do |node|
          new(spec, tree, node)
        end
      end  

      #
      def self.applicable?(spec)
        spec['kind']
      end

      # Validate type.
      #
      def validate(spec)
        node.kind.to_s == spec['kind']
      end

    end

  end

end
