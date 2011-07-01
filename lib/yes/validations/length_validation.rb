module YES

  # Validate if a node's value is within a certain length.
  # The value is converted to a string using #to_s for the
  # comparison.
  #
  #   //code:
  #     length: 3
  #
  # A valid code value could then have no more than three characters.
  class LengthValidation < NodeValidation

    # Validate if a node value is within a certain length.
    # The value is converted to a string using #to_s for the
    # comparison.
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
      spec['length']
    end

    #
    # @return [Boolean] validity
    def valid?
      return true unless applicable?
      match_delta(spec['length'], node.value.to_s.size)
    end

  end

end
