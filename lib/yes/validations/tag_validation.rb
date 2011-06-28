module YES

  #
  class TagValidation < NodeValidation

    #
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
