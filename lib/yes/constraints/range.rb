module YES

  module Constraints

    # Validate the a nodes value is within a certain range.
    # Primarily this works for numeric values, but it can
    # also work for string in ASCII/UTF-8 order, by using 
    # a 2-element array for comparison.
    #
    #   //note:
    #     range: ['A','G']
    #
    # Valid values for are then only A, B, C, D, E, F and G.
    class Range < NodeConstraint

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
        spec['range']
      end

      # Validate if a node is the only one of it's value in a sequence
      # or mapping.
      #
      # @return [Boolean] validity
      def valid?
        return true unless applicable?
        return true if match_delta(range, node.transform)
        false
      end

      #
      def range
        spec['range']
      end

    end

  end

end
