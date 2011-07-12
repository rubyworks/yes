module YES

  module Constraints

    # Takes a list of relative YPaths and ensures they are present.
    # This is most useful for ensuring the existance of mapping fields.
    #
    #     foo:
    #       requires:
    #         - bar
    #
    # A valid document would be:
    #
    #     foo:
    #       bar: true
    #
    # The literal meaing of this example is "if `foo` exists, the make sure
    # `foo/bar` also exists.
    #
    # @return [Array<Validaiton>]
    class Requires < NodeConstraint

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
        spec['requires']
      end

      # Validates whether a matching node must be present within it's parent.
      #
      # @return [Boolen] validity
      def valid?
        return true unless applicable?

        requires = Array(spec['requires'])

        requires.each do |rq|
          case rq
          when /^\// # absolute path
            rq_nodes = tree.select(rq)
          else
            rq_nodes = node.select(rq)
          end
          return false unless rq_nodes.size > 0
        end

      end

    end

  end

end
