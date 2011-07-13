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
      def validate(spec)
        regexp = parse_regexp(spec['regexp'])
        regexp =~ node.value ? true : false
      end

      # The regular expression from `spec`.
      #
      # @return [Regexp] spec's regular expression
      def parse_regexp(re)
        case re
        when /^\/(.*?)\/(\w*)$/
          ::Regexp.new($1)  # TODO: modifiers
        else
          ::Regexp.new(re)
        end
      end

    end

  end

end
