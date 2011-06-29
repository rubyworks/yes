module YES

  # Validate matching values against a regular expression.
  # All values are converted to strings (using #to_s) for comparison.
  #
  #   //pin:
  #     regexp: /^\d\s\d\d$/
  #
  class RegexpValidation < NodeValidation

    #
    # @return [Boolean] validity
    def valid?
      return true unless applicable?
      regexp =~ node.value.to_s
    end

    # The regular expression from `spec`.
    #
    # @return [Regexp] spec's regular expression
    def regexp
      @regexp ||= Regexp.new(spec['regexp'])
    end

    #
    def self.applicable?(spec)
      spec['regexp']
    end

  end

end
