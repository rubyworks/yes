module YES

  #
  class RangeValidation < NodeValidation

    #
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
