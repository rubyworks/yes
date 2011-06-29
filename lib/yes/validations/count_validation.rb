module YES

  # Count validation ensures there are a limited number of matching
  # nodes in a document.
  #
  #   //gold:
  #     count: 1..4
  #
  # Would mean the `gold` mapping key could only appear 1 to 4 times
  # in the entire document.
  class CountValidation < TreeValidation

    # Validate count ensure there is a minimum and/or maximum
    # number of matching nodes.
    def valid?
      return true unless applicable?
      match_delta(spec['count'], nodes.size)
    end

    # Only applicable if `count` entry is in the spec.
    def self.applicable?(spec)
      spec['count']
    end

  end

end
