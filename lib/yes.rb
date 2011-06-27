# YAML Easy Schema
#
# Issues
#
# * Matching fully-quaified tags.
# * Handling namespaces.
# * Handling YAML version directive.
#
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

    # TODO: how to handle sub-paths?
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
      @edit << ['required', spec]
    end
  end

  # Validate range ensure there is a minimum and/or maximum
  # number of matching nodes.
  def validate_range(spec, nodes)
    return unless spec['range']
    min, max = spec['range'].split('..')
    if nodes.size < min.to_i
      @edit << ['range', spec, nodes.size]
    end
    next if max == 'n'
    if nodes.size > max.to_i
      @edit << ['range', spec, nodes.size]
    end
  end

  #
  def validate_type(spec, nodes)
    return unless spec['type']
    type = spec['type']
    nodes.each do |node|
      next if type_match(node, type)
      # TODO: more types
      @edit << ['type', spec, catholic_node(node)]
    end
  end  

  #
  def validate_pattern(spec, nodes)
    return unless spec['pattern']
    pattern = Regexp.new(spec['pattern'])
    nodes.each do |node|
      next if pattern =~ node.value
      @edit << ['pattern', spec, catholic_node(node)]
    end
  end

  #
  def validate_fnmatch(spec, nodes)
    return unless spec['fnmatch']
    fnmatch = spec['fnmatch']
    nodes.each do |node|
      next if File.fnmatch(fnmatch, node.value)
      @edit << ['fnmatch', spec, catholic_node(node)]
    end
  end

  #
  def type_match(node, type)
    node_type = base_type_id(node)
    pick_type = TYPE_MATCH[type] || [type]
    pick_type.any?{ |t| t == node_type }
  end

  #
  def fixed_type_id(node)
    type_id = node.type_id
    if type_id
      type_id
    else
      node.kind.to_s
    end
  end

  #
  def base_type_id(node)
    fixed_type_id(node).split(':').last
  end

  # Covert a YAML node (Syck) node into a generic representation.
  #
  # NOTE: Should `style` be part of this? Also, is `kind` the proper term?
  def catholic_node(node)
    n = {}
    n['tag']   = node.type_id #base_type_id(node)
    n['kind']  = node.kind.to_s
    n['value'] = node.value
    n['style'] = node.instance_variable_get('@style').to_s
    n
  end

  #
  TYPE_MATCH = {
    'date' => ['timestamp#ymd'],
    'bool' => ['bool#no', 'bool#yes']
  }

end
