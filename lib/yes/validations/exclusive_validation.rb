module YES

  # Validate exclusion. This can either be a boolean expression in
  # which case it validates that there is no more than one matching
  # node. Otherwise, the value is taken to be a ypath and validates
  # that there are no matching paths if the main selection is present.
  #--
  # TODO: Provide $parent$ path substitution ?
  #++
  class ExclusiveValidation < TreeValidation

    #
    # @return [Boolean] validity
    def valid?
      return true unless applicable?

      exclusive = spec['exclusive']

      case exclusive
      when true, false
        nodes.size <= 1
      else
        ex_nodes = tree.select(exclusive)
        nodes.size == 0 or ex_nodes.size == 0
      end
    end

    # Only applicable if `exclusive` feild is in the spec.
    def self.applicable?(spec)
      spec['exclusive']
    end

  end

end
