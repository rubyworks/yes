module YES

  #
  class CountValidation < TreeValidation

    # Validate count ensure there is a minimum and/or maximum
    # number of matching nodes.
    def valid?
      return true unless applicable?
      match_delta(spec['count'], nodes.size)
    end

    #
    def self.applicable?(spec)
      spec['count']
    end

  end

end
