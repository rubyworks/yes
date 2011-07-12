module YES

  module Constraints

    # The Path constraints is used to constraint a node to a select YPath.
    # This may seem redundant, since the node to apply the constraint against
    # was already selected via a YPath, however it's primary use is as part
    # of complex selectors.
    #
    class Path < NodeConstraint

      #
      # @return [Array<Validaiton>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)
        nodes.map do |node|
          new(spec, tree, node)
        end
      end  

      #
      def self.applicable?(spec)
        spec['path']
      end

      # Validate type.
      #
      def valid?
        return true unless applicable?
        tree.select(path).include?(node)
      end

    end

  end

end
