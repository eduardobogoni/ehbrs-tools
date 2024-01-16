# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/videos/container'
require 'ehbrs_ruby_utils/videos/stream'

module EhbrsRubyUtils
  module Videos2
    class File < ::EhbrsRubyUtils::Videos::Container
      enable_simple_cache

      TIME_PATTERN = /(\d+):(\d{2}):(\d{2})(?:\.(\d+))/.freeze

      class << self
        def time_to_seconds(time)
          m = TIME_PATTERN.match(time)
          raise "Time pattern not find in \"#{time}\"" unless m

          hmsf_to_seconds(m[1], m[2], m[3], m[4])
        end

        private

        def hmsf_to_seconds(hour, minute, second, float_part)
          r = (hour.to_f * 3600) + (minute.to_f * 60) + second.to_f
          r += float_part.to_f / (10**float_part.length) if float_part
          r
        end
      end

      private

      def tracks_uncached
        streams.reject do |t|
          t.codec_type == ::EhbrsRubyUtils::Videos::Stream::CODEC_TYPE_DATA
        end
      end
    end
  end
end
