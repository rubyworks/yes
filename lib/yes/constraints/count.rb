module YES

  module Constraints

    # Count validation ensures there are a limited number of matching
    # nodes in a document.
    #
    #   //gold:
    #     count: 1..4
    #
    # Would mean the `gold` mapping key could only appear 1 to 4 times
    # in the entire document.
    class Count < TreeConstraint

      #
      # @return [Array<Constraint>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)
        [new(spec, tree, nodes)]
      end

      # Only applicable if `count` entry is in the spec.
      def self.applicable?(spec)
        spec['count']
      end

      # Validate count ensure there is a minimum and/or maximum
      # number of matching nodes.
      def validate(spec)
        count = spec['count']
        match_delta(count, nodes.size)
      end

    end

  end

end
