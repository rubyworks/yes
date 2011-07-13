module YES

  # Simple validatily check.
  #
  # @return [Boolean]
  def self.valid?(schema, yaml)
    yes = YES::Lint.new(@schema)
    yes.validate(@yaml).empty? 
  end

end

#
require 'yaml'

require 'yes/constraints/abstract_constraint'
require 'yes/constraints/node_constraint'
require 'yes/constraints/tree_constraint'

require 'yes/constraints/range'
require 'yes/constraints/regexp'
require 'yes/constraints/fnmatch'

require 'yes/constraints/tag'
require 'yes/constraints/type'

require 'yes/constraints/count'
require 'yes/constraints/length'
require 'yes/constraints/requires'
require 'yes/constraints/inclusive'
require 'yes/constraints/exclusive'

require 'yes/constraints/value'
require 'yes/constraints/key'

require 'yes/logical_and'
require 'yes/lint'

