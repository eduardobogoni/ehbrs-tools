# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/executables'
require 'ehbrs_ruby_utils/videos/stream'
require 'json'
require 'taglib'

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

      ::EhbrsRubyUtils::Videos::Stream.lists.codec_type.each_value do |stream_type|
        define_method stream_type.to_s.pluralize do
          streams.select { |stream| stream.codec_type == stream_type }
        end
      end

      private

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
