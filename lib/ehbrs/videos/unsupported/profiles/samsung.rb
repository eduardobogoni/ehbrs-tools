# frozen_string_literal: true

require 'ehbrs/videos/unsupported/checks/invalid_extension'
require 'ehbrs/videos/unsupported/profiles/base'

module Ehbrs
  module Videos
    module Unsupported
      module Profiles
        class Samsung < ::Ehbrs::Videos::Unsupported::Profiles::Base
          AUDIO_SUPPORTED_CODECS = %w[aac ac3 eac3 mp3 vorbis].freeze
          AUDIO_UNSUPPORTED_CODECS = %w[dts].freeze

          VIDEO_SUPPORTED_CODECS = %w[h264 mpeg4 hevc].freeze
          VIDEO_UNSUPPORTED_CODECS = %w[].freeze

          SUBTITLE_SUPPORTED_CODECS = %w[ass dvd subrip].freeze
          SUBTITLE_UNSUPPORTED_CODECS = %w[mov].freeze

          OTHER_SUPPORTED_CODECS = %w[png ttf].freeze

          MPEG4_EXTRA_SUPPORTED = %w[].freeze
          MPEG4_EXTRA_UNSUPPORTED = %w[dx50 xvid].freeze

          def initialize
            add_check('invalid_extension', '.m4v')
          end
        end
      end
    end
  end
end
