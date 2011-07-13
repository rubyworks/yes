require 'yes'

When 'Given a schema' do |text|
  @schema = text
  @lint   = YES::Lint.new(@schema)
end

When 'Then this YAML document is valid' do |yaml|
  @yaml = yaml
  errors = @lint.validate(yaml)
  errors.assert.empty?
end

When 'And this YAML document is valid' do |yaml|
  @yaml = yaml
  errors = @lint.validate(yaml)
  errors.assert.empty?
end

When 'But this YAML document is not valid' do |yaml|
  @yaml = yaml
  errors = @lint.validate(yaml)
  errors.refute.empty?
end

