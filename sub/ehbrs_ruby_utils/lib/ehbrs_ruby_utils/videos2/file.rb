# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/videos/file'
require 'ehbrs_ruby_utils/videos/stream'

module EhbrsRubyUtils
  module Videos2
    class File < ::EhbrsRubyUtils::Videos::File
      enable_simple_cache

      private

      def tracks_uncached
        streams.reject do |t|
          t.codec_type == ::EhbrsRubyUtils::Videos::Stream::CODEC_TYPE_DATA
        end
      end
    end
  end
end
