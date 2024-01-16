# frozen_string_literal: true

require 'ehbrs_ruby_utils/videos2/unsupported/fixes/supported_codec'

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      module Checks
        class CodecExtraUnsupported
          TYPE = :stream

          common_constructor :codec, :extra

          def check(track)
            return nil unless track.codec_name == codec
            return nil unless track.extra.downcase.include?(extra.downcase)

            "Unsupported extra \"#{extra}\" for codec \"#{codec}\" and track #{track}"
          end

          def fix
            ::EhbrsRubyUtils::Videos2::Unsupported::Fixes::SupportedCodec.new
          end
        end
      end
    end
  end
end
