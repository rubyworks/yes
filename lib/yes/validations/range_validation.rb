module YES

  # Validate the a nodes value is within a certain range.
  # Primarily this works for numeric values, but it can
  # also work for string in ASCII/UTF-8 order, by using 
  # a 2-element array for comparison.
  #
  #   //note:
  #     range: ['A','G']
  #
  # Valid values for are then only A, B, C, D, E, F and G.
  class RangeValidation < NodeValidation

    #
    # @return [Boolean] validity
    def valid?
      return true unless applicable?
      return true if match_delta(range, node.value)
      false
    end

    #
    def self.applicable?(spec)
      spec['range']
    end

  end

end
