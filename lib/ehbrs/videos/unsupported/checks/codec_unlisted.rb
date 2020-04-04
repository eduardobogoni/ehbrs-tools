# frozen_string_literal: true

module Ehbrs
  module Videos
    module Unsupported
      module Checks
        class CodecUnlisted
          common_constructor :listed_codecs

          def check(track)
            return nil if listed_codecs.include?(track.codec)

            "Not listed codec \"#{track.codec}\" (Track: #{track}, listed: #{listed_codecs})"
          end

          def fix
            nil
          end
        end
      end
    end
  end
end
