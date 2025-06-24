# frozen_string_literal: true

module EhbrsRubyUtils
  class CircularListSpreader
    class GroupLevel
      include ::EhbrsRubyUtils::CircularListSpreader::BaseLevel
      enable_simple_cache

      common_constructor :label

      def push(path, item)
        child_path = path.dup
        current = child_path.shift
        if child_path.any?
          push_group_level(current, child_path, item)
        else
          push_item_level(current, item)
        end
      end

      def pop
        children.values.max.pop
      end

      def pop_all
        r = []
        r << pop while remaining?
        r
      end

      def remaining_i
        children.values.inject(0) { |a, e| a + e.remaining_i }
      end

      def total_i
        children.values.inject(0) { |a, e| a + e.total_i }
      end

      private

      attr_accessor :item

      def push_group_level(current, child_path, item)
        children[current] ||= self.class.new(current)
        children[current].push(child_path, item)
      end

      def children
        @children ||= {}
      end

      def push_item_level(current, item)
        raise "Key \"#{current}\" already used" if children[current].present?

        children[current] = ::EhbrsRubyUtils::CircularListSpreader::ItemLevel.new(item)
      end
    end
  end
end
