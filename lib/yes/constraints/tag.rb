module YES

  module Constraints

    # Validate that a node has specific tag.
    # This ensure all the matching nodes have the given tag.
    # Be sure to used quotes when starting the tag with `!`.
    #
    # NOTE: the tag should honer %TAG directives in the document, but as of 
    # yet this is not supported. Thus fully qualified tags need to be used
    # for anything beyond default !! and ! tags.
    #
    class Tag < NodeConstraint

      #
      # @return [Array<Constraint>]
      def self.checklist(spec, tree, nodes)
        return [] unless applicable?(spec)
        nodes.map do |node|
          new(spec, tree, node)
        end
      end

      #
      def self.applicable?(spec)
        spec['tag']
      end

      # Validate the tag.
      #
      # @return [Boolean] validity
      def validate(spec)
        tag = spec['tag']
        match_tag(tag, node)
      end

      private

      def match_tag(tag, node)
        node_tag = node.type_id || "tag:yaml.org,2002:#{node.kind}"
        case node_tag
        when /^x-private:/
          tag == $' or tag == '!'+$'
        when /^tag:yaml.org,2002:/
          tag == node_tag or tag == '!!'+$'
        else
          tag == node_tag
        end
      end

    end

  end

end
