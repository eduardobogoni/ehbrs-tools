# frozen_string_literal: true

require 'ehbrs/videos/profiles/same_quality'
require 'ehbrs/videos/unsupported/fixes/supported_container'

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

        def container_fix_args
          ['-f', ::Ehbrs::Videos::Unsupported::Fixes::SupportedContainer::FIX_FORMAT]
        end
      end
    end
  end
end
