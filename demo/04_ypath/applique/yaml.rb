require 'yaml'

When 'Given a YAML document' do |text|
  @yaml = YAML.parse(text)
end

