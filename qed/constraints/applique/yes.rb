require 'yes'

When 'Given a YAML document' do |text|
  @yaml = text #YAML.load(text)
end

When 'And a YAML document' do |text|
  @yaml = text #YAML.load(text)
end

When 'Given a schema' do |text|
  @schema = text
end


