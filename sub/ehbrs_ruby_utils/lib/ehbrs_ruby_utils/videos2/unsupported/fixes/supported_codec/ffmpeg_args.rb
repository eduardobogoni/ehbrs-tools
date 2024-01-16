# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      module Fixes
        class SupportedCodec
          class FfmpegArgs
            FORMATS = {
              i: :index,
              f: :target_codec,
              t: :codec_type_letter
            }.freeze

            SOURCE_COMMON_ARGS = ['-%tcodec:%i', '%f'].freeze
            SOURCE_AUDIO_ARGS = SOURCE_COMMON_ARGS
            SOURCE_SUBTITLE_ARGS = SOURCE_COMMON_ARGS
            SOURCE_VIDEO_ARGS = SOURCE_COMMON_ARGS + ['-filter:%t', 'format=yuv420p']

            TARGET_CODECS = {
              audio: 'aac',
              video: 'libx264',
              subtitle: 'ass'
            }.freeze

            acts_as_instance_method
            common_constructor :owner, :track

            # @return [Array<String>]
            def result
              source_args_by_codec_type.map { |arg| target_arg(arg) }
            end

            private

            # @return [String]
            def codec_type_letter
              track.codec_type.to_s[0].downcase
            end

            # @return [String]
            def index
              track.index.to_s
            end

            # @return [Array<String>]
            def source_args_by_codec_type
              self.class.const_get("SOURCE_#{track.codec_type.to_s.underscore.upcase}_ARGS")
            end

            # @param arg [String]
            # @return [String]
            def target_arg(arg)
              FORMATS.inject(arg) do |a, e|
                a.gsub("%#{e.first}", send(e.last))
              end
            end

            # @return [String]
            def target_codec
              TARGET_CODECS.fetch(track.codec_type.to_s.underscore.to_sym)
            end
          end
        end
      end
    end
  end
end
