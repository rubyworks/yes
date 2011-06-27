require 'yes'

class YES

  def self.cli(*argv)
    schema_file = argv[0]
    target_file = argv[1]

    validator = new(File.new(schema_file))
    edit = validator.validate(File.new(target_file))

    if edit.size == 0
      #$stderr.puts "valid: #{target_file}"
    else
      $stderr.puts edit.to_yaml
      exit -1
    end
  end

end
