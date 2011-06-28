require 'yes'

module YES

  def self.cli(*argv)
    schema_file = argv[0]
    target_file = argv[1]

    lint = Lint.new(File.new(schema_file))
    edit = lint.validate(File.new(target_file))

    if edit.size == 0
      #$stderr.puts "valid: #{target_file}"
    else
      $stderr.puts edit.to_yaml
      exit -1
    end
  end

end
