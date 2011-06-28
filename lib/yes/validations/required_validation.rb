module YES

  # TODO: For the moment this is the same as Inclusive, but I don't think that is right.
  class RequiredValidation < TreeValidation

    #
    def valid?
      return true unless applicable?

      required = spec['required']

      case required
      when true, false
        nodes.size > 0
      else
        in_nodes = tree.select(required)
        nodes.size == 0 or in_nodes.size > 0
      end
    end

    #
    def self.applicable?(spec)
      spec['required']
    end

  end

end
