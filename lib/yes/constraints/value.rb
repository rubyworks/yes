module YES

  module Constraints

    # Validate if a node's _value_ conforms to a constraint, where a 
    # value is either an sequence element or a mapping value.
    #
    #   //authors:
    #     type: seq
    #     value:
    #       type: str
    #
    # A valid code value could then have no more than three characters.
    class Value < NodeConstraint

      # For value constraint, the work is all handled by the
      # checklist method.
      #
      # @return [Array<Constraint>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)

        vspec = spec['value']
        list  = []

        nodes.each do |node|
          case node.kind
          when :seq
            YES.constraints.each do |c|
              list.concat(c.checklist(vspec, tree, node.children))
            end
          when :map
            YES.constraints.each do |c|
              list.concat(c.checklist(vspec, tree, node.value.values))
            end
          else
            # TODO: might value for scalars have a useful meaning?
            raise "value constraint does not apply to scalars"
          end
        end

        list
      end

      #
      #
      def self.applicable?(spec)
        spec['value']
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
