# frozen_string_literal: true

require 'addressable/uri'
require 'aranha/parsers/source_address'
require 'eac_ruby_utils/core_ext'
require 'ultimate_lyrics/lyrics'
require 'ultimate_lyrics/parser'

module UltimateLyrics
  class ProviderSearch
    common_constructor :provider, :song_metadata

    # @return [String]
    def escaped_url
      ::Addressable::URI.escape(url)
    end

    # @return [String]
    def url
      url_fields.inject(provider.url) { |a, e| e.apply(a) }
    end

    # @return []
    def url_fields
      provider.url_fields.map { |provider_url_field| song_metadata.field(provider_url_field) }
    end

    # @return [UltimateLyrics::Lyrics]
    def lyrics
      ::UltimateLyrics::Lyrics.new(song_metadata, provider.name, parser.result)
    end

    # @return [UltimateLyrics::Parser]
    def lyrics_original_text
      ::Aranha::Parsers::SourceAddress.detect_sub(escaped_url).content
                                      .force_encoding(provider.encoding)
    rescue ::Aranha::Parsers::SourceAddress::FetchContentError
      nil
    end

    # @return [UltimateLyrics::Parser]
    def parser
      ::UltimateLyrics::Parser.new(provider, lyrics_original_text)
    end

    def to_s
      "ProviderSearch[#{provider} | #{song_metadata}]"
    end
  end
end
