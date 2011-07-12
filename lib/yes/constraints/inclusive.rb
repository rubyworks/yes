module YES

  module Constraints

    # Inclusion can either be a boolean expression in
    # which case it validates that there is at least one matching
    # node. Otherwise, the value is taken to be a ypath and validates
    # that there are matching paths if the main selection is present.
    #--
    # TODO: Provide $parent$ path substitution ?
    #++
    class Inclusive < TreeConstraint

      #
      # @return [Array<Validaiton>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)
        [new(spec, tree, nodes)]
      end

      # Only applicable if `inclusive` field in in the spec.
      def self.applicable?(spec)
        spec['inclusive']
      end

      # Validate inclusion - This can either be a boolean expression in
      # which case it validates that there is at least one matching
      # node. Otherwise, the value is taken to be a ypath and validates
      # that there are matching paths if the main selection is present.
      #
      # @return [Boolean] validity
      def valid?
        return true unless applicable?

        inclusive = spec['inclusive']

        case inclusive
        when true, false
          nodes.size > 0
        else
          in_nodes = tree.select(inclusive)
          nodes.size == 0 or in_nodes.size > 0
        end
      end

    end

  end

end
