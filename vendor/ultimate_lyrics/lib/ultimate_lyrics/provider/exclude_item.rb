# frozen_string_literal: true

require 'ultimate_lyrics/provider/item'

module UltimateLyrics
  class Provider
    class ExcludeItem < ::UltimateLyrics::Provider::Item
      def apply_from_delimiters(source)
        source.delimited_without_outer(begin_with, end_with)
      end

      def apply_from_tag(source)
        source.delimited_without_outer(tag, "</#{tag_name}>")
      end
    end
  end
end
