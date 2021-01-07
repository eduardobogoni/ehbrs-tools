# frozen_string_literal: true

require 'ehbrs/videos/unsupported/profiles/base'

module Ehbrs
  module Videos
    module Unsupported
      module Profiles
        class Aoc < ::Ehbrs::Videos::Unsupported::Profiles::Base
          AUDIO_SUPPORTED_CODECS = %w[aac ac3 mp2 mp3].freeze
          AUDIO_UNSUPPORTED_CODECS = %w[eac3 vorbis].freeze

          VIDEO_SUPPORTED_CODECS = %w[h264 mpeg4].freeze
          VIDEO_UNSUPPORTED_CODECS = %w[hevc].freeze

          SUBTITLE_SUPPORTED_CODECS = %w[ass dvd_subtitle hdmv_pgs_subtitle subrip].freeze
          SUBTITLE_UNSUPPORTED_CODECS = %w[mov_text].freeze

          OTHER_SUPPORTED_CODECS = %w[].freeze

          MPEG4_EXTRA_SUPPORTED = %w[xvid].freeze
          MPEG4_EXTRA_UNSUPPORTED = %w[].freeze
        end
      end
    end
  end
end
