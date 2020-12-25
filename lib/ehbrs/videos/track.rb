# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/videos/stream'

module Ehbrs
  module Videos
    class Track < ::SimpleDelegator
      def codec
        codec_name
      end

      def number
        index
      end

      def extra
        ffprobe_data.fetch(:codec_tag_string).to_s
      end

      def to_s
        "[#{codec_type}(#{number}): #{codec}/#{language || '-'}" +
          extra.if_present('') { |v| " | #{v}" } + ']'
      end
    end
  end
end
