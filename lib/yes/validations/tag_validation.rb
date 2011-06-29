module YES

  # Validate that a node has specific tag.
  #
  class TagValidation < NodeValidation

    #
    # @return [Boolean] validity
    def valid?
      return true unless applicable?
      spec['tag'] == (node.type_id || node.kind).to_s
    end

    #
    def self.applicable?(spec)
      spec['tag']
    end

  end

end
