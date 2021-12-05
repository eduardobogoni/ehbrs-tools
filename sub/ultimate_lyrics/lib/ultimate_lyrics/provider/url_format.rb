# frozen_string_literal: true

module UltimateLyrics
  class Provider
    class UrlFormat
      common_constructor :node

      def apply(value)
        replace_chars.inject(value) { |a, e| a.gsub(e, with) }
      end

      def replace_chars
        ::CGI.unescapeHTML(node.attribute('replace').text).each_char.to_a
      end

      def with
        node.attribute('with').text
      end
    end
  end
end
