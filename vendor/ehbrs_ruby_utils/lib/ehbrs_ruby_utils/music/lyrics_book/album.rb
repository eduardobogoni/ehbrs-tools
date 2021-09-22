# frozen_string_literal: true

require 'ehbrs_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/music/lyrics_book/resource'

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
          songs.lazy.map { |v| v.tag.artist }.find(&:present?)
        end

        def title
          songs.lazy.map { |v| v.tag.album }.find(&:present?)
        end

        def songs_uncached
          ::EhbrsRubyUtils::Music::LyricsBook::Song.create_list(self, path.children)
        end
      end
    end
  end
end
