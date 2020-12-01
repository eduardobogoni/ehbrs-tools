# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/executables'
require 'ehbrs_ruby_utils/videos/container/info'
require 'ehbrs_ruby_utils/videos/stream'
require 'json'

module EhbrsRubyUtils
  module Videos
    class Container
      enable_simple_cache
      common_constructor :path do
        self.path = path.to_pathname
      end

      ::EhbrsRubyUtils::Videos::Stream.lists.codec_type.each_value do |stream_type|
        define_method stream_type.to_s.pluralize do
          streams.select { |stream| stream.codec_type == stream_type }
        end
      end

      def probe_data
        info.to_h.deep_symbolize_keys
      end

      private

      def info_uncached
        ::EhbrsRubyUtils::Videos::Container::Info.new(
          ::JSON.parse(
            ::EhbrsRubyUtils::Executables.ffprobe.command(
              '-hide_banner', '-print_format', 'json', '-show_format', '-show_streams', path
            ).execute!
          )
        )
      end

      def streams_uncached
        info.ffprobe_data.fetch(:streams).map do |stream_ffprobe_data|
          ::EhbrsRubyUtils::Videos::Stream.new(stream_ffprobe_data)
        end
      end
    end
  end
end
