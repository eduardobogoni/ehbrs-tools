# frozen_string_literal: true

module Ehbrs
  module Videos
    module Unsupported
      module Fixes
        class SupportedContainer
          FIX_FORMAT = 'matroska'

          def ffmpeg_args(_video)
            ['-f', FIX_FORMAT]
          end
        end
      end
    end
  end
end
