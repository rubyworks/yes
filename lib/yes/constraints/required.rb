module YES

  module Constraints

    #
    # TODO: For the moment this is the same as Inclusive.
    #       It was originall inteded to work like {RequiresValidation}
    #       but it rpoved hard to work out the validation procedure
    #       when matching to the subfield. If we can fix it maybe we will
    #       keep, but for now THIS IS NOT USED.
    #
    class Required < TreeConstraint

      #
      # @return [Array<Validaiton>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)
        [new(spec, tree, nodes)]
      end

      # Only applicable if `required` field appears in spec.
      def self.applicable?(spec)
        spec['required']
      end

      # Validates whether a matching node must be present within it's parent.
      #
      # @return [Boolean] validity
      def valid?
        return true unless applicable?

        required = spec['required']

        case required
        when true, false
          nodes.size > 0
        else
          in_nodes = tree.select(required)
          nodes.size == 0 or in_nodes.size > 0
        end
      end

    end

  end

end
