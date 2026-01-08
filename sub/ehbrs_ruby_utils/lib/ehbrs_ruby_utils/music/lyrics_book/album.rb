# frozen_string_literal: true

module EhbrsRubyUtils
  module Music
    class LyricsBook
      class Album < ::EhbrsRubyUtils::Music::LyricsBook::Resource
        enable_simple_cache

        def book
          parent
        end

        def first_previous
          previous.if_present { |v| v.songs.last }
        end

        def valid?
          songs.any?
        end

        def header_title
          "#{songs.first.number}-#{songs.last.number} | #{artist} | #{title}"
        end

        def artist
          from_songs_tag(:artist)
        end

        def title
          from_songs_tag(:album)
        end

        private

        def songs_uncached
          ::EhbrsRubyUtils::Music::LyricsBook::Song.create_list(self, path.children)
        end

        def from_songs_tag(field)
          songs.lazy.map { |v| v.tag.send(field) }.find(&:present?)
        end
      end
    end
  end
end
