# YAML Easy Schema
class YES

  #
  require 'yaml'

  #
  attr :schema

  #
  attr :edit

  #
  def initialize(schema)
    @schema = YAML.load(schema)
    @edit   = []
  end

  #
  def validate(yaml)
    @tree = YAML.parse(yaml)
    @edit = []

    @schema.each do |ypath, spec|
      validate_ypath(ypath, spec)
    end

    return @edit
  end

  def validate_ypath(ypath, spec)
    nodes = @tree.select(ypath)
    validate_spec(spec, nodes)
    spec.each do |r, s|
      if r[0,1] =~ /\W/
        rel_ypath = ypath + r
        rel_spec  = s
        validate_ypath(rel_ypath, rel_spec)
      end
    end
  end

  #
  def validate_spec(spec, nodes)
    validate_required(spec, nodes)
    validate_range(spec, nodes)
    validate_type(spec, nodes)
    validate_pattern(spec, nodes)
    validate_fnmatch(spec, nodes)
  end

  #
  def validate_required(spec, nodes)
    return unless spec['required']
    if spec['required'] && nodes.empty?
      @edit << [:required, spec]
    end
  end

  # Validate range ensure there is a minimum and/or maximum
  # number of matching nodes.
  def validate_range(spec, nodes)
    return unless spec['range']
    min, max = spec['range'].split('..')
    if nodes.size < min.to_i
      @edit << [:range, spec]
    end
    next if max == 'n'
    if nodes.size > max.to_i
      @edit << [:range, spec]
    end
  end

  #
  def validate_type(spec, nodes)
    return unless spec['type']
    type = spec['type']
    nodes.each do |node|
      next if type_match(node, type)
      # TODO: more types
      @edit << [:type, spec, node]
    end
  end  

  #
  def validate_pattern(spec, nodes)
    return unless spec['pattern']
    pattern = Regexp.new(spec['pattern'])
    nodes.each do |node|
      next if pattern =~ node.value
      @edit << [:pattern, spec, node]
    end
  end

  #
  def validate_fnmatch(spec, nodes)
    return unless spec['fnmatch']
    fnmatch = spec['fnmatch']
    nodes.each do |node|
      next if File.fnmatch(fnmatch, node.value)
      @edit << [:fnmatch, spec, node]
    end
  end

  #
  def type_match(node, type)
    node_type = node.type_id.split(':').last
    pick_type = TYPE_MATCH[type] || [type]
    pick_type.any?{ |t| t == node_type }
  end

  #
  TYPE_MATCH = {
    'date' => ['timestamp#ymd']
  }

end
