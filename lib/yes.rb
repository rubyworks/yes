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

  #
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

  # Process all validations.
  def validate_spec(spec, nodes)
    validate_required  spec, nodes
    validate_exclusive spec, nodes
    validate_range     spec, nodes
    validate_type      spec, nodes
    validate_pattern   spec, nodes
    validate_fnmatch   spec, nodes
  end

  # Validates whether a mathcing node must be present. If a boolean value 
  # than the ypath selection must return at least one match. If the value
  # is a string, it is taken to be a ypath selection, such that if the
  # main selection is not empty then this sub-selection cannot be either.
  def validate_required(spec, nodes)
    return unless spec['required']
    required = spec['required']
    case requried
    when true, false, nil
      if nodes.empty?
        @edit << ['required', spec]
      end
    else
      req_nodes = @tree.select(required)
      if nodes.size != 0 && ex_nodes.size == 0
        @edit << ['required', spec, req_nodes.size]  # maybe generalized req_nodes instead of size?
      end
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

  # Validate exclusion - This can either be a boolean expression in
  # which case it validates that there is no more than one mathcing
  # node. Otherwise, the value is taken to be a ypath and validates
  # that there a no matching paths if the main selection is present.
  def validate_exclusive(spec, nodes)
    return unless spec['exclusive']
    exclusive = spec['exclusive']
    case exclusive
    when true, false, nil
      if nodes.size > 1
        @edit << ['exclusive', spec, nodes.size]
      end
    else
      ex_nodes = @tree.select(exclusive)
      if nodes.size > 1 && ex_nodes.size > 1
        @edit << ['exclusive', spec, ex_nodes.size]  # maybe generalized ex_nodes instead of size?
      end
    end
  end

  # Validate the tag type. This ensure all the matching nodes
  # have the same base type specified. The base type is the portion
  # of a tag the occcurs after a `:', that is to say, regardless of
  # namespace.
  def validate_type(spec, nodes)
    return unless spec['type']
    type = spec['type']
    nodes.each do |node|
      next if type_match(node, type)
      # TODO: more types
      @edit << ['type', spec, catholic_node(node)]
    end
  end  

  # Validate matching values against a regular expression.
  # All values are converted to strings (using #to_s) for comparison.
  def validate_pattern(spec, nodes)
    return unless spec['pattern']
    pattern = Regexp.new(spec['pattern'])
    nodes.each do |node|
      next if pattern =~ node.value.to_s
      @edit << ['pattern', spec, catholic_node(node)]
    end
  end

  # Validate file glob match. This uess standard unix-style file matching,
  # primarily '*` and `?`, to detrmine a mathing node value.
  # All values are converted to strings (using #to_s) for comparison.
  def validate_fnmatch(spec, nodes)
    return unless spec['fnmatch']
    fnmatch = spec['fnmatch']
    nodes.each do |node|
      next if File.fnmatch(fnmatch, node.value.to_s)
      @edit << ['fnmatch', spec, catholic_node(node)]
    end
  end

  # Get the nodes base type see if matches the given type.
  # The {TYPE_MATCH} chart is used to sse if the node's
  # base type coresponds to the given type.
  #
  # @return [Boolean] node's type matches given type
  def type_match(node, type)
    node_type = base_type_id(node)
    pick_type = TYPE_MATCH[type] || [type]
    pick_type.any?{ |t| t == node_type }
  end

  # Return the `type_id` of a node. If the type_id is `nil` then
  # returns the `kind`.
  #
  # @return [String] type_id or kind of node
  def fixed_type_id(node)
    type_id = node.type_id
    if type_id
      type_id
    else
      node.kind.to_s
    end
  end

  # Get the base of the node's type tag, i.e. the part after the last `:`.
  #
  # @return [String] base type
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
