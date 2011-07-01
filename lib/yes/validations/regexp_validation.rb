module YES

  # Validate matching values against a regular expression.
  # All values are converted to strings (using #to_s) for comparison.
  #
  #   //pin:
  #     regexp: /^\d\s\d\d$/
  #
  class RegexpValidation < NodeValidation

    # Validate matching values against a regular expression.
    # All values are converted to strings (using #to_s) for comparison.
    #
    # @return [Array<Validaiton>]
    def self.validate(ypath, spec, tree, nodes)
      return [] unless applicable?(spec)
      nodes.map do |node|
        new(ypath, spec, tree, node)
      end
    end

    #
    def self.applicable?(spec)
      spec['regexp']
    end

    #
    # @return [Boolean] validity
    def valid?
      return true unless applicable?
      regexp =~ node.value
    end

    # The regular expression from `spec`.
    #
    # @return [Regexp] spec's regular expression
    def regexp
      @regexp ||= Regexp.new(spec['regexp'])
    end

  end

end
