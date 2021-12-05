# frozen_string_literal: true

module UltimateLyrics
  class SongMetadata
    class Field
      enable_listable
      lists.add_symbol :sources, :album, :artist, :title, :track, :year

      common_constructor :song_metadata, :field

      def apply(string)
        field.apply(string, value)
      end

      def value
        field.value(song_metadata.send(field.source_attribute))
      end

      def to_s
        "[#{song_metadata} | #{field}]"
      end
    end
  end
end
