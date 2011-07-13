module YES

  module Constraints

    # Validate from a selction of choices.
    #
    #   choice: [M,F]
    #
    class Choice < NodeConstraint

      #
      # @return [Array<Constraint>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)
        nodes.map do |node|
          new(spec, tree, node)
        end
      end

      # Only applicable if `choice` field is in spec.
      def self.applicable?(spec)
        spec['choice']
      end

      # Validate that a node's value is amoung a provided
      # list of values.
      #
      # @return [Boolean] validity
      def validate(spec)
        choice = Array(spec['choice'])
        choice.include?(node.transform)
      end

    end

  end

end

