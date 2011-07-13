--- !ruby/object:Gem::Specification 
name: "yes"
version: !ruby/object:Gem::Version 
  prerelease: 
  version: 0.0.1
platform: ruby
authors: 
- Thomas Sawyer
autorequire: 
bindir: bin
cert_chain: []

date: 2011-07-13 00:00:00 Z
dependencies: 
- !ruby/object:Gem::Dependency 
  name: qed
  prerelease: false
  requirement: &id001 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        version: "0"
  type: :development
  version_requirements: *id001
- !ruby/object:Gem::Dependency 
  name: detroit
  prerelease: false
  requirement: &id002 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        version: "0"
  type: :development
  version_requirements: *id002
description: YAML Easy Schemas it a straight-foward but powerful YPath-based schema format and validation program for YAML documents.
email: transfire@gmail.com
executables: 
- yes-lint
extensions: []

extra_rdoc_files: 
- README.rdoc
files: 
- .ruby
- .yardopts
- bin/yes-lint
- data/yes/yes.yes
- lib/yes/cli.rb
- lib/yes/constraints/abstract_constraint.rb
- lib/yes/constraints/choice.rb
- lib/yes/constraints/count.rb
- lib/yes/constraints/exclusive.rb
- lib/yes/constraints/fnmatch.rb
- lib/yes/constraints/inclusive.rb
- lib/yes/constraints/key.rb
- lib/yes/constraints/kind.rb
- lib/yes/constraints/length.rb
- lib/yes/constraints/node_constraint.rb
- lib/yes/constraints/range.rb
- lib/yes/constraints/regexp.rb
- lib/yes/constraints/required.rb
- lib/yes/constraints/requires.rb
- lib/yes/constraints/tag.rb
- lib/yes/constraints/tree_constraint.rb
- lib/yes/constraints/type.rb
- lib/yes/constraints/value.rb
- lib/yes/genclass.rb
- lib/yes/lint.rb
- lib/yes/logical_and.rb
- lib/yes.rb
- HISTORY.rdoc
- README.rdoc
- QED.rdoc
- LICENSE.rdoc
- THANKS.rdoc
homepage: http://rubyworks.github.com/yes
licenses: 
- BSD-2-Clause
- BSD-2-Clause
post_install_message: 
rdoc_options: 
- --title
- YES API
- --main
- README.rdoc
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
required_rubygems_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
requirements: []

rubyforge_project: "yes"
rubygems_version: 1.8.2
signing_key: 
specification_version: 3
summary: YAML Easy Schema
test_files: []

