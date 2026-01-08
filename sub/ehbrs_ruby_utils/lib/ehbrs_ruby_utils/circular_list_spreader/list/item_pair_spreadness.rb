# frozen_string_literal: true

module EhbrsRubyUtils
  class CircularListSpreader
    class List
      class ItemPairSpreadness
        enable_method_class
        enable_simple_cache
        common_constructor :list, :left_index, :right_index do
          raise "Right is not greater than left (Left: #{left_index}, Right: #{right_index}" unless
          left_index < right_index
        end

        # @return [Integer]
        def distance
          to_right_distance * to_left_distance
        end

        # @return [Array]
        def left_path
          list.items.fetch(left_index).item.to_circular_list_spreader_path
        end

        # @return [Array]
        def right_path
          item_on_index_path(right_index)
        end

        # @return [Integer]
        def to_left_distance
          right_index - left_index
        end

        # @return [Integer]
        def to_right_distance
          list.count - right_index + left_index
        end

        # @return [Integer]
        def result
          similarity * distance
        end

        private

        # @return [Integer]
        def difference_uncached
          lpath = item_on_index_path(left_index).reverse
          rpath = item_on_index_path(right_index).reverse
          r = lpath.count - 1
          while r >= 0
            return r + 1 if lpath.fetch(r) != rpath.fetch(r)

            r -= 1
          end

          0
        end

        def similarity_uncached
          item_on_index_path(left_index).count - 1 - difference
        end

        def item_on_index_path(index)
          list.items.fetch(index).item.to_circular_list_spreader_path
        end
      end
    end
  end
end
