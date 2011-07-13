module YES

  #
  def self.constraints
    @constraints ||= []
  end

  #
  module Constraints

    # AbstractConstraint serves as the base class for
    # all other constraints.
    class AbstractConstraint

      #
      def self.inherited(base)
        YES.constraints << base
      end

      # noop
      def self.checklist(spec, tree, nodes)
        []
      end

      #
      def initialize(spec, tree, nodes)
        @spec  = spec
        @tree  = tree
        @nodes = nodes
      end

    public

      #
      attr :nodes

      # 
      attr :spec

      #
      attr :tree

      # MUST OVERRIDE THIS METHOD IN SUBCLASSES
      #
      def validate(spec)
        raise "undefined method -- `validate'"
      end

      # MUST OVERRIDE THIS METHOD IN SUBCLASSES
      #
      def self.applicable?(spec)
        raise "undefined class method -- `applicable?'"
      end

      #
      def valid? 
        return true unless applicable?
        recurse_valid?(spec)
      end

      #
      def applicable?
        self.class.applicable?(spec)
      end

    private

      #
      def recurse_valid?(spec=nil)
        spec ||= self.spec
        case spec
        when Array  # logical-or
          spec.any?{ |sub_spec| recurse_valid?(sub_spec) }
        else
          validate(spec)
        end
      end

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
          value >= $1.to_f && value < $2.to_f
        when /^(.*)\.\.(.*)$/
          value >= $1.to_f && value <= $2.to_f
        when /^\[(.*)\,(.*)\]$/
          value >= $1.to_f && value <= $2.to_f
        when /^\[(.*)\,(.*)\)$/
          value >= $1.to_f && value < $2.to_f
        when /^\((.*)\,(.*)\]$/
          value > $1.to_f && value <= $2.to_f
        when /^\((.*)\,(.*)\)$/
          value > $1.to_f && value < $2.to_f
        else # assume range is just a number
          range.to_f == value.to_f
        end
      end

    end

  end

end
