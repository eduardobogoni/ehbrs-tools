# frozen_string_literal: true

require 'ehbrs_ruby_utils/videos2/unsupported/checks/invalid_extension'
require 'ehbrs_ruby_utils/videos2/unsupported/profiles/base'

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      module Profiles
        class Samsung < ::EhbrsRubyUtils::Videos2::Unsupported::Profiles::Base
          AUDIO_SUPPORTED_CODECS = %w[aac ac3 eac3 mp3 vorbis].freeze
          AUDIO_UNSUPPORTED_CODECS = %w[dts].freeze

          VIDEO_SUPPORTED_CODECS = %w[h264 mpeg4 hevc mjpeg].freeze
          VIDEO_UNSUPPORTED_CODECS = %w[].freeze

          SUBTITLE_SUPPORTED_CODECS = %w[ass dvd dvd_subtitle hdmv_pgs_subtitle subrip].freeze
          SUBTITLE_UNSUPPORTED_CODECS = %w[mov mov_text].freeze

          OTHER_SUPPORTED_CODECS = %w[png ttf].freeze

          MPEG4_EXTRA_SUPPORTED = %w[].freeze
          MPEG4_EXTRA_UNSUPPORTED = %w[dx50 xvid].freeze

          def initialize
            super
            add_check('invalid_extension', '.m4v')
          end
        end
      end
    end
  end
end
