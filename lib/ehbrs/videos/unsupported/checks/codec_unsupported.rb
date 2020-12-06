# frozen_string_literal: true

require 'ehbrs/videos/unsupported/fixes/supported_codec'

module Ehbrs
  module Videos
    module Unsupported
      module Checks
        class CodecUnsupported
          TYPE = :stream

          common_constructor :codec

          def check(track)
            return nil unless track.codec == codec

            "Unsupported codec \"#{codec}\" for track #{track}"
          end

          def fix
            ::Ehbrs::Videos::Unsupported::Fixes::SupportedCodec.new
          end
        end
      end
    end
  end
end
