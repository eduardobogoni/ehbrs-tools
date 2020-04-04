# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Ehbrs
  module Videos
    class Track
      FFPROBE_PATTERN = /\A\s*Stream\s\#(\d+:\d+)(?:\(([^\)]+)\))?:\s*([^:]+):\s*([a-z0-9]+)(.*)/
                        .freeze
      class << self
        def create_from_string(string)
          m = FFPROBE_PATTERN.match(string)
          return nil unless m

          new(m[1].to_i, m[3], m[2], m[4], m[5].strip)
        end
      end

      common_constructor :number, :type, :language, :codec, :extra

      def to_s
        "[#{type}(#{number}): #{codec}/#{language || '-'}" +
          extra.if_present('') { |v| " | #{v}" } + ']'
      end
    end
  end
end
