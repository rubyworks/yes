module YES

  # Takesa list to YPath, usually relative YPaths and ensures
  # they are present. This is most useful for ensuring the existance
  # ot mapping fields.
  class RequiresValidation < NodeValidation

    #
    def valid?
      return true unless applicable?

      requires = Array(spec['requires'])

      requires.each do |rq|
        case rq
        when /^\// # absolute path
          rq_nodes = tree.select(rq)
        else
          yp = File.join(ypath, rq)
          rq_nodes = tree.select(yp)
        end
        return false unless rq_nodes.size > 0
      end

    end

    #
    def self.applicable?(spec)
      spec['requires']
    end

  end

end
