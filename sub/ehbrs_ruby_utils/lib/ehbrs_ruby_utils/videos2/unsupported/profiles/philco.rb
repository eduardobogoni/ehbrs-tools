# frozen_string_literal: true

require 'ehbrs_ruby_utils/videos2/unsupported/profiles/base'

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      module Profiles
        class Philco < ::EhbrsRubyUtils::Videos2::Unsupported::Profiles::Base
          AUDIO_SUPPORTED_CODECS = %w[aac ac3 eac3 mp3 vorbis wmav2].freeze
          AUDIO_UNSUPPORTED_CODECS = %w[dts opus].freeze

          VIDEO_SUPPORTED_CODECS = %w[h264 mpeg4].freeze
          VIDEO_UNSUPPORTED_CODECS = %w[hevc msmpeg4v3].freeze

          SUBTITLE_SUPPORTED_CODECS = %w[ass dvd dvd_subtitle hdmv_pgs_subtitle mov_text
                                         subrip].freeze
          SUBTITLE_UNSUPPORTED_CODECS = %w[mov].freeze

          OTHER_SUPPORTED_CODECS = %w[png ttf].freeze

          MPEG4_EXTRA_SUPPORTED = %w[xvid].freeze
          MPEG4_EXTRA_UNSUPPORTED = %w[divx dx50].freeze
        end
      end
    end
  end
end
