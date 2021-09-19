# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/executables'
require 'ehbrs_ruby_utils/videos/stream'
require 'json'
require 'taglib'
require 'ultimate_lyrics/provider_search'
require 'ultimate_lyrics/song_metadata'

module EhbrsRubyUtils
  module Videos
    class Container
      class << self
        def from_file(path)
          new(path)
        end
      end

      enable_simple_cache
      common_constructor :path do
        self.path = path.to_pathname
      end

      delegate :tag, to: :tag_file
      delegate :to_s, to: :path

      ::EhbrsRubyUtils::Videos::Stream.lists.codec_type.each_value do |stream_type|
        define_method stream_type.to_s.pluralize do
          streams.select { |stream| stream.codec_type == stream_type }
        end
      end

      # @param provider [UltimateLyrics::Provider]
      # @return [UltimateLyrics::Lyrics]
      def lyrics_by_provider(provider)
        ::UltimateLyrics::ProviderSearch.new(provider, song_metadata).lyrics
      end

      private

      # @return [UltimateLyrics::SongMetadata]
      def song_metadata_uncached
        ::UltimateLyrics::SongMetadata.new(
          ::UltimateLyrics::SongMetadata::Field.lists.sources.values
          .map { |source| [source, tag.send(source)] }.to_h
        )
      end

      def probe_data_uncached
        ::JSON.parse(
          ::EhbrsRubyUtils::Executables.ffprobe.command(
            '-hide_banner', '-print_format', 'json', '-show_format', '-show_streams', path
          ).execute!
        ).deep_symbolize_keys.freeze
      end

      def streams_uncached
        probe_data.fetch(:streams).map do |stream_ffprobe_data|
          ::EhbrsRubyUtils::Videos::Stream.new(stream_ffprobe_data)
        end
      end

      # @return [TagLib::FileRef]
      def tag_file_uncached
        ::TagLib::FileRef.new(path.to_path)
      end
    end
  end
end
