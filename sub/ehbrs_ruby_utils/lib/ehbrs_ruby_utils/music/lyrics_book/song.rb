# frozen_string_literal: true

require 'ehbrs_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/music/lyrics_book/resource'

module EhbrsRubyUtils
  module Music
    class LyricsBook
      class Song < ::EhbrsRubyUtils::Music::LyricsBook::Resource
        enable_simple_cache
        delegate :book, to: :album
        delegate :provider, to: :book
        delegate :tag, :to_s, to: :container

        DEFAULT_TITLE = 'Unknown title'

        def album
          parent
        end

        # @return [Array<String>
        def fs_object_id
          %w[artist album title].map { |k| tag.send(k) }
        end

        def lyrics
          fetch_lyrics unless lyrics_cached?
          cached_lyrics
        end

        def valid?
          tag.present?
        end

        def lyrics_cached?
          lyrics_cache.stored?
        end

        def cached_lyrics
          ::YAML.load_file(lyrics_cache.content_path)
        end

        def header_title
          "#{number} - #{title}"
        end

        def title
          tag.if_present(DEFAULT_TITLE, &:title)
        end

        private

        def container_uncached
          ::EhbrsRubyUtils::Videos::Container.new(path)
        end

        def fetch_lyrics
          lyrics = fetched_lyrics
          lyrics_cache.write(lyrics.to_yaml)
        end

        def fetched_lyrics
          container.lyrics_by_provider(provider)
        end

        def lyrics_cache
          fs_cache.child(provider.identifier)
        end

        def number_uncached
          previous.if_present(0, &:number) + 1
        end
      end
    end
  end
end
