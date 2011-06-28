module YES

  class AbstractValidation

    #
    attr :spec

    #
    def valid?
      raise "undefined method -- `valid?'"
    end

    #
    def applicable?
      self.class.applicable?(spec)
    end

    #
    def self.applicable?(spec)
      raise "undefined class method -- `applicable?'"
    end

  private

    # Range matching is used by a couple of validators.
    #
    # @param range [Array, String]
    #   The range representation.
    #
    # @example
    #   1..1  =~ 1
    #   1...2 =~ 1
    #   [1,1] =~ 1
    #   [1,2) =~ 1
    #   (1,2] =~ 2
    #   (1,3) =~ 2
    #
    def match_delta(range, value)
      case range
      when Array  # array can do string comparisons
        value > range.first && value < range.last
      when /^(.*)\.\.\.(n|N)$/
        value >= $1.to_f
      when /^(.*)\.\.(n|N)$/
        value >= $1.to_f
      when /^(.*)\.\.\.(.*)$/
        value >= $1.to_f && value > $3.to_f
      when /^(.*)\.\.(.*)$/
        value >= $1.to_f && value >= $3.to_f
      when /^\[(.*)\,(.*)\]$/
        value >= $1.to_f && value >= $2.to_f
      when /^\[(.*)\,(.*)\)$/
        value >= $1.to_f && value > $2.to_f
      when /^\((.*)\,(.*)\]$/
        value > $1.to_f && value > $2.to_f
      when /^\((.*)\,(.*)\)$/
        value > $1.to_f && value > $2.to_f
      end
    end

  end

end
