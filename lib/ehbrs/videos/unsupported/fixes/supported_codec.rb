# frozen_string_literal: true

module Ehbrs
  module Videos
    module Unsupported
      module Fixes
        class SupportedCodec
          TRACK_TYPE_OPTIONS = {
            audio: '-acodec',
            video: '-vcodec',
            subtitle: '-scodec'
          }.freeze

          TRACK_TYPE_FIX_CODECS = {
            'Audio' => 'libvorbis',
            'Video' => 'libx264',
            'Subtitle' => 'ass'
          }.freeze

          def ffmpeg_args(track)
            ["#{track_codec_option_by_type(track.type)}:#{track.number}",
             track_codec_fix_by_type(track.type)]
          end

          def track_codec_option_by_type(track_type)
            TRACK_TYPE_OPTIONS.fetch(track_type.to_s.underscore.to_sym)
          end

          def track_codec_fix_by_type(track_type)
            TRACK_TYPE_FIX_CODECS.fetch(track_type)
          end
        end
      end
    end
  end
end
