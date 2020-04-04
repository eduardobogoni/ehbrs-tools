# frozen_string_literal: true

require 'ehbrs/videos/unsupported/fixes/supported_codec'

module Ehbrs
  module Videos
    module Unsupported
      module Checks
        class CodecExtraUnsupported
          common_constructor :codec, :extra

          def check(track)
            return nil unless track.codec == codec
            return nil unless track.extra.downcase.include?(extra.downcase)

            "Unsupported extra \"#{extra}\" for codec \"#{codec}\" and track #{track}"
          end

          def fix
            ::Ehbrs::Videos::Unsupported::Fixes::SupportedCodec.new
          end
        end
      end
    end
  end
end
