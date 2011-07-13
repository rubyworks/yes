module YES

  module Constraints

    # Validate if a mapping node's _keys_ conforms to a constraint.
    #
    #   //authors:
    #     type: map
    #     key:
    #       type: str
    #
    class Key < NodeConstraint

      # For key constraint, the work is all handled by the
      # checklist method.
      #
      # @return [Array<Constraint>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)

        key_spec = spec['key']
        list     = []

        nodes.each do |node|
          case node.kind
          when :map
            YES.constraints.each do |c|
              list.concat(c.checklist(key_spec, tree, node.value.keys))
            end
          else
            raise "key constraint applies only to mappings"
          end
        end

        list
      end

      #
      #
      def self.applicable?(spec)
        spec['key']
      end

      #
      # no-op
      #
      # @return [Boolean] validity
      def validate(spec)
      end

    end

  end

end
