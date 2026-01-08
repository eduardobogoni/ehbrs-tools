# frozen_string_literal: true

RSpec.describe EhbrsRubyUtils::CircularListSpreader do
  let(:node_class) do
    Class.new do
      class << self
        def from_file(file)
          from_hash(nil, 'ROOT', EacRubyUtils::Yaml.load_file(file))
        end

        def from_hash(parent, label, hash)
          new(parent, label).children_from_hash(hash)
        end

        def name
          'NodeClass'
        end
      end

      common_constructor :parent, :label
      attr_reader :children

      def children_from_hash(hash)
        @children = if hash.is_a?(Hash)
                      hash.map { |k, v| self.class.from_hash(self, k, v) }
                    else
                      false
                    end

        self
      end

      def id
        to_circular_list_spreader_path.join(' | ')
      end

      def leaf?
        !children.is_a?(Enumerable)
      end

      def recursive_leafs
        if leaf?
          [self]
        else
          children.flat_map(&:recursive_leafs)
        end
      end

      def to_circular_list_spreader_path
        return [] if parent.blank?

        parent.if_present([], &:to_circular_list_spreader_path) + [label]
      end

      def to_s
        label
      end
    end
  end

  include_examples 'source_target_fixtures', __FILE__

  def source_data(source_file)
    described_class.new(node_class.from_file(source_file).recursive_leafs).result.map(&:id)
  end
end
