# frozen_string_literal: true

require 'ehbrs/videos/profiles/same_quality'

module Ehbrs
  module Videos
    module Unsupported
      class FixProfile
        include ::Ehbrs::Videos::Profiles::SameQuality

        common_constructor :video
        set_callback :swap, :after do
          video.all_fixes.each do |fix|
            next unless fix.respond_to?(:after_swap)

            fix.after_swap(self)
          end
        end

        def name
          "fix_for_#{::File.basename(video.file)}"
        end

        def ffmpeg_args
          r = fix_args
          r += container_fix_args unless r.include?('-f')
          r + super
        end

        private

        def fix_args
          ['-c', 'copy'] + video.ffmpeg_fix_args +
            video.tracks.flat_map(&:ffmpeg_fix_args)
        end

        def track_fix_args(track)
          ["#{track_codec_option_by_type(track.type)}:#{track.number}",
           track.passed? ? 'copy' : track_codec_fix_by_type(track.type)]
        end

        def track_codec_option_by_type(track_type)
          TRACK_TYPE_OPTIONS.fetch(track_type)
        end

        def track_codec_fix_by_type(track_type)
          TRACK_TYPE_FIX_CODECS.fetch(track_type)
        end

        def container_fix_args
          ['-f', ::Ehbrs::Videos::Unsupported::Fixes::SupportedContainer::FIX_FORMAT]
        end
      end
    end
  end
end
