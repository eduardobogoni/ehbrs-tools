# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Videos
    class Stream
      enable_simple_cache
      enable_listable

      lists.add_symbol :codec_type, :audio, :video, :subtitle, :data, :attachment

      common_constructor :ffprobe_data do
        self.ffprobe_data = ffprobe_data.symbolize_keys.freeze
        self.class.lists.codec_type.value_validate!(codec_type)
      end

      lists.codec_type.each_value do |v|
        define_method "#{v}?" do
          codec_type == v
        end
      end

      # @return [Integer]
      def codec_tag
        ffprobe_data.fetch(:codec_tag).to_i(16)
      end

      # @return [String]
      def to_s
        [index, codec_type, codec_name, language, codec_tag_string].join('|')
      end

      def to_h
        ffprobe_data
      end

      %i[index].each do |method_name|
        define_method method_name do
          ffprobe_data.fetch(method_name)
        end
      end

      %i[codec_name codec_long_name codec_tag_string height width].each do |method_name|
        define_method method_name do
          ffprobe_data[method_name]
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

      def language_with_title
        [language, title].compact_blank.if_present { |v| v.join('_').variableize }
      end

      def title
        tags[:title]
      end
    end
  end
end
