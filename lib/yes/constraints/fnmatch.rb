module YES

  module Constraints

    # Validate file glob match. This uess standard unix-style file matching,
    # primarily '*` and `?`, to detrmine a mathing node value.
    # All values are converted to strings (using #to_s) for comparison.
    #--
    # TODO: better name then `FNMatch`?
    #++
    class FNMatch < NodeConstraint

      #
      # @return [Array<Constraint>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)
        nodes.map do |node|
          new(spec, tree, node)
        end
      end

      # Only applicable if `fnmatch` field is in spec.
      def self.applicable?(spec)
        spec['fnmatch']
      end

      # Validate file glob match. This uess standard unix-style file matching,
      # primarily '*` and `?`, to detrmine a mathing node value.
      # All values are converted to strings (using #to_s) for comparison.
      #
      # @return [Boolean] validity
      def validate(spec)
        fnmatch = spec['fnmatch']

        File.fnmatch(fnmatch, node.value)
      end

    end

  end

end
