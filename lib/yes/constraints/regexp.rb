module YES

  module Constraints

    # Validate matching values against a regular expression.
    # All values are converted to strings (using #to_s) for comparison.
    #
    #   //pin:
    #     regexp: /^\d\s\d\d$/
    #
    class Regexp < NodeConstraint

      #
      # @return [Array<Validaiton>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)
        nodes.map do |node|
          new(spec, tree, node)
        end
      end

      #
      def self.applicable?(spec)
        spec['regexp']
      end

      # Validate matching values against a regular expression.
      # All values are converted to strings (using #to_s) for comparison.
      #
      # @return [Boolean] validity
      def valid?
        return true unless applicable?
        regexp =~ node.value ? true : false
      end

      # The regular expression from `spec`.
      #
      # @return [Regexp] spec's regular expression
      def regexp
        @regexp ||= (
          re = spec['regexp']
          case re
          when /^\/(.*?)\/(\w*)$/
            ::Regexp.new($1)  # TODO: modifiers
          else
            ::Regexp.new(re)
          end
        )
      end

    end

  end

end
