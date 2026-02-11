# frozen_string_literal: true

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
