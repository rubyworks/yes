module YES

  #
  class InclusiveValidation < TreeValidation

    #
    def valid?
      return true unless applicable?

      inclusive = spec['inclusive']

      case inclusive
      when true, false
        nodes.size > 0
      else
        in_nodes = tree.select(inclusive)
        nodes.size == 0 or in_nodes.size > 0
      end
    end

    #
    def self.applicable?(spec)
      spec['inclusive']
    end

  end

end
