module YES

  # Validate from a selction of choices.
  #
  #   choice: [M,F]
  #
  class ChoiceValidation < NodeValidation

    # Validate that a node's value is amoung a provided
    # list of values.
    #
    # @return [Array<Validaiton>]
    def self.validate(ypath, spec, tree, nodes)
      return [] unless applicable?(spec)
      nodes.map do |node|
        new(ypath, spec, tree, node)
      end
    end

    # Only applicable if `choice` field is in spec.
    def self.applicable?(spec)
      spec['choice']
    end

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

  end

end
