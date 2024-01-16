# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      module Fixes
        class SupportedCodec
          class FfmpegArgs
            TRACK_TYPE_OPTIONS = {
              audio: '-acodec',
              video: '-vcodec',
              subtitle: '-scodec'
            }.freeze

            TRACK_TYPE_FIX_CODECS = {
              audio: 'aac',
              video: 'libx264',
              subtitle: 'ass'
            }.freeze

            acts_as_instance_method
            common_constructor :owner, :track

            # @return [Array<String>]
            def result
              ["#{track_codec_option_by_type}:#{track.index}", track_codec_fix_by_type]
            end

            private

            # @return [String]
            def track_codec_option_by_type
              TRACK_TYPE_OPTIONS.fetch(track.codec_type.to_s.underscore.to_sym)
            end

            # @return [String]
            def track_codec_fix_by_type
              TRACK_TYPE_FIX_CODECS.fetch(track.codec_type.to_s.underscore.to_sym)
            end
          end
        end
      end
    end
  end
end
