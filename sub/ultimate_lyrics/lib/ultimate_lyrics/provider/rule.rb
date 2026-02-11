# frozen_string_literal: true

module UltimateLyrics
  class Provider
    class Rule
      common_constructor :node

      def items
        node.xpath('./item').map { |v| item_class.new(self, v) }
      end

      def item_class
        ::UltimateLyrics::Provider.const_get("#{type.camelize}Item")
      end

      def apply(string)
        url? ? apply_with_url(string) : apply_without_url(string)
      end

      def to_s
        "Rule[#{type} | #{items.join(', ')}]"
      end

      def type
        node.name
      end

      def url?
        items.any?(&:url?)
      end

      private

      def apply_without_url(string)
        items.inject(string) { |a, e| e.apply(a) }
      end

      def apply_with_url(string)
        url_item, id_item = url_items
        id_item.apply(string).if_present { |v| url_item.apply(v) }
      end

      def url_items
        raise "There is more than 2 items in #{rule}" if items.count != 2

        url_item = items.find(&:url?) || raise("No URL item found in #{rule}")
        id_item = items.find(&:delimiters?) || raise("No ID item found in #{rule}")
        [url_item, id_item]
      end
    end
  end
end
