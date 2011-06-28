module YES

  # Validate if a node value is within a certain length.
  # The value is converted to a string using #to_s for the
  # comparison.
  class LengthValidation < NodeValidation

    #
    def valid?
      return true unless applicable?
      match_delta(spec['length'], node.value.to_s.size)
    end

    #
    def self.applicable?(spec)
      spec['length']
    end

  end

end
