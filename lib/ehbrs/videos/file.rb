# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/videos/track'
require 'ehbrs_ruby_utils/executables'
require 'ehbrs_ruby_utils/videos/container'

module Ehbrs
  module Videos
    class File < ::EhbrsRubyUtils::Videos::Container
      enable_simple_cache

      TIME_PATTERN = /(\d+):(\d{2}):(\d{2})(?:\.(\d+))/.freeze

      class << self
        def seconds_to_time(seconds)
          t = seconds.floor
          hmsf_to_time((t / 3600), ((t / 60) % 60), (t % 60), (seconds - t).round(3))
        end

        def time_to_seconds(time)
          m = TIME_PATTERN.match(time)
          raise "Time pattern not find in \"#{time}\"" unless m

          hmsf_to_seconds(m[1], m[2], m[3], m[4])
        end

        private

        def hmsf_to_time(hour, minute, second, float_part)
          r = [hour, minute, second].map { |y| y.to_s.rjust(2, '0') }
          r += float_part > 0.0 ? ".#{float_part.to_s.gsub(/\A(0|[^\d])+/, '')}" : '.0'
          r
        end

        def hmsf_to_seconds(hour, minute, second, float_part)
          r = hour.to_f * 3600 + minute.to_f * 60 + second.to_f
          r += float_part.to_f / (10**float_part.length) if float_part
          r
        end
      end

      private

      def tracks_uncached
        streams.map { |stream| ::Ehbrs::Videos::Track.new(stream) }.reject do |t|
          t.codec_type == ::EhbrsRubyUtils::Videos::Stream::CODEC_TYPE_DATA
        end
      end

      def content_uncached
        ::EhbrsRubyUtils::Executables.ffprobe.command(path).execute!(output: :stderr).scrub
      end

      def duration_uncached
        m = /Duration\:\s*(#{TIME_PATTERN})/.match(content)
        raise 'Duration pattern not find in content' unless m

        self.class.time_to_seconds(m[1])
      end

      def duration_s_uncached
        self.class.seconds_to_time(duration)
      end
    end
  end
end
