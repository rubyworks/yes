module YES

  # Validate file glob match. This uess standard unix-style file matching,
  # primarily '*` and `?`, to detrmine a mathing node value.
  # All values are converted to strings (using #to_s) for comparison.
  #--
  # TODO: better name then `Fnmatch`?
  #++
  class FnmatchValidation < NodeValidation

    #
    def valid?
      return true unless applicable?
      File.fnmatch(fnmatch, node.value.to_s)
    end

    #
    def fnmatch
      spec['fnmatch']
    end

    #
    def self.applicable?(spec)
      spec['fnmatch']
    end

  end

end
