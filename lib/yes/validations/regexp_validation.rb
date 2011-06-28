module YES

  # Validate matching values against a regular expression.
  # All values are converted to strings (using #to_s) for comparison.
  class RegexpValidation < NodeValidation

    #
    def valid?
      return true unless applicable?
      regexp =~ node.value.to_s
    end

    #
    def regexp
      @regexp ||= Regexp.new(spec['regexp'])
    end

    #
    def self.applicable?(spec)
      spec['regexp']
    end

  end

end
