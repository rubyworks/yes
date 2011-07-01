module YES

  # Validate file glob match. This uess standard unix-style file matching,
  # primarily '*` and `?`, to detrmine a mathing node value.
  # All values are converted to strings (using #to_s) for comparison.
  #--
  # TODO: better name then `Fnmatch`?
  #++
  class FnmatchValidation < NodeValidation

    # Validate file glob match. This uess standard unix-style file matching,
    # primarily '*` and `?`, to detrmine a mathing node value.
    # All values are converted to strings (using #to_s) for comparison.
    #
    # @return [Array<Validaiton>]
    def self.validate(ypath, spec, tree, nodes)
      return [] unless applicable?(spec)
      nodes.map do |node|
        new(ypath, spec, tree, node)
      end
    end

    # Only applicable if `fnmatch` field is in spec.
    def self.applicable?(spec)
      spec['fnmatch']
    end

    #
    # @return [Boolean] validity
    def valid?
      return true unless applicable?
      File.fnmatch(fnmatch, node.value)
    end

    #
    # @return [String] fnmatch pattern
    def fnmatch
      spec['fnmatch']
    end

  end

end
