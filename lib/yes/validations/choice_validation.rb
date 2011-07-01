module YES

  # Validate from a selction of choices.
  #
  #   choice: [M,F]
  #
  class ChoiceValidation < NodeValidation

    #
    # @return [Boolean] validity
    def valid?
      return true unless applicable?
      choice.include?(node.transform)
    end

    #
    # @return [String] selection list
    def choice
      Array(spec['choice'])
    end

    # Only applicable if `choice` field is in spec.
    def self.applicable?(spec)
      spec['choice']
    end

  end

end
