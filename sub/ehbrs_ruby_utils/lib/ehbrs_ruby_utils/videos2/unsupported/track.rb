# frozen_string_literal: true

require 'ehbrs_ruby_utils/videos2/unsupported/check_support'

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      class Track < ::SimpleDelegator
        include ::EhbrsRubyUtils::Videos2::Unsupported::CheckSupport

        enable_speaker
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
