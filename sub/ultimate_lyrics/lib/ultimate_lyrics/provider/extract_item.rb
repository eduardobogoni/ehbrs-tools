# frozen_string_literal: true

require 'ultimate_lyrics/provider/item'

module UltimateLyrics
  class Provider
    class ExtractItem < ::UltimateLyrics::Provider::Item
      def apply_from_delimiters(source)
        source.delimited_inner(begin_with, end_with)
      end

      def apply_from_tag(source)
        source.delimited_inner(tag, "</#{tag_name}>")
      end

      def apply_from_url(source)
        url.gsub('{id}', source)
      end
    end
  end
end
