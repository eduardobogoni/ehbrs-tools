# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos
    class Stream
      enable_simple_cache
      enable_listable

      lists.add_symbol :codec_type, :audio, :video, :subtitle, :data, :attachment

      DURATION_TAG_TO_SECONDS_PARSER = /\A(\d{2}):(\d{2}):(\d{2}.\d+)\z/.to_parser do |m|
        (m[1].to_i * 3600) + (m[2].to_i * 60) + m[3].to_f
      end

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

      # @return [ActiveSupport::Duration, nil]
      def duration
        duration_from_root || duration_from_tags
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

      private

      # @return [ActiveSupport::Duration, nil]
      def duration_from_root
        ffprobe_data[:duration].if_present do |v|
          ::ActiveSupport::Duration.build(v.to_f)
        end
      end

      # @return [ActiveSupport::Duration, nil]
      def duration_from_tags
        tags[:DURATION].if_present do |v|
          ::ActiveSupport::Duration.build(DURATION_TAG_TO_SECONDS_PARSER.parse!(v))
        end
      end
    end
  end
end
