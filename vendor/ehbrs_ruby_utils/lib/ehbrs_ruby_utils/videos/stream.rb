# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Videos
    class Stream
      enable_simple_cache
      enable_listable

      lists.add_symbol :codec_type, :audio, :video, :subtitle, :data

      common_constructor :ffprobe_data do
        self.ffprobe_data = ffprobe_data.symbolize_keys.freeze
        self.class.lists.codec_type.value_validate!(codec_type)
      end

      lists.codec_type.each_value do |v|
        define_method "#{v}?" do
          codec_type == v
        end
      end

      def to_s
        "#{index}|#{codec_type}|#{codec_name}|#{language}"
      end

      def to_h
        ffprobe_data
      end

      %i[index codec_name codec_long_name].each do |method_name|
        define_method method_name do
          ffprobe_data.fetch(method_name)
        end
      end

      def codec_type
        ffprobe_data.fetch(:codec_type).to_sym
      end

      def tags
        ffprobe_data[:tags].if_present({}, &:symbolize_keys)
      end

      def language
        tags[:language]
      end
    end
  end
end
