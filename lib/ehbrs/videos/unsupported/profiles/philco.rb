# frozen_string_literal: true

require 'ehbrs/videos/unsupported/profiles/base'

module Ehbrs
  module Videos
    module Unsupported
      module Profiles
        class Philco < ::Ehbrs::Videos::Unsupported::Profiles::Base
          AUDIO_SUPPORTED_CODECS = %w[aac ac3 eac3 mp3].freeze
          AUDIO_UNSUPPORTED_CODECS = %w[dts].freeze

          VIDEO_SUPPORTED_CODECS = %w[h264 mpeg4].freeze
          VIDEO_UNSUPPORTED_CODECS = %w[hevc msmpeg4v3].freeze

          SUBTITLE_SUPPORTED_CODECS = %w[ass dvd subrip].freeze
          SUBTITLE_UNSUPPORTED_CODECS = %w[mov].freeze

          OTHER_SUPPORTED_CODECS = %w[png ttf].freeze

          MPEG4_EXTRA_SUPPORTED = %w[xvid].freeze
          MPEG4_EXTRA_UNSUPPORTED = %w[dx50].freeze
        end
      end
    end
  end
end
