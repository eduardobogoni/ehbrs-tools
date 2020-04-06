# frozen_string_literal: true

require 'ehbrs/videos/unsupported/check_support'

module Ehbrs
  module Videos
    module Unsupported
      class Track < ::SimpleDelegator
        include ::Ehbrs::Videos::Unsupported::CheckSupport

        enable_console_speaker
        enable_simple_cache
        attr_reader :video

        def initialize(video, track)
          @video = video
          super(track)
        end

        def banner
          aggressions_banner("Track #{self}")
        end

        def check_set_key
          :track_check_set
        end

        delegate :options, to: :video
      end
    end
  end
end
