# frozen_string_literal: true

module EhbrsRubyUtils
  class CircularListSpreader
    class List
      require_sub __FILE__, require_dependency: true

      class << self
        def empty
          new([], 0)
        end
      end

      enable_simple_cache
      common_constructor :items, :inserted_at
      compare_by :spreadness, :inserted_at
      delegate :count, to: :items

      def insert(position, item_level)
        dup_items = items.dup
        dup_items.insert(position, item_level)
        self.class.new(dup_items, position)
      end

      def items_pair_enumerator
        ::Enumerator.new do |enum|
          (count - 1).times do |li|
            ((li + 1)..(count - 1)).each do |ri|
              enum.yield(li, ri)
            end
          end
        end
      end

      def to_s
        items.map { |i| i.item.to_s }.join(', ')
      end

      private

      # @return [Integer]
      def spreadness_uncached
        items_pair_enumerator.inject(0) { |a, e| a + item_pair_spreadness(*e) }
      end
    end
  end
end
