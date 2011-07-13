module YES

  module Constraints

    # Validate if a node's value is within a certain length.
    # The value is converted to a string using #to_s for the
    # comparison.
    #
    #   //code:
    #     length: 3
    #
    # A valid code value could then have no more than three characters.
    class Length < NodeConstraint

      #
      #
      # @return [Array<Constraint>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)
        nodes.map do |node|
          new(spec, tree, node)
        end
      end

      #
      #
      def self.applicable?(spec)
        spec['length']
      end

      #
      # Validate if a node value is within a certain length.
      # The value is converted to a string using #to_s for the
      # comparison.
      #
      # @return [Boolean] validity
      def validate(spec)
        length = spec['length']
        match_delta(length, node.value.to_s.size)
      end

    end

  end

end
