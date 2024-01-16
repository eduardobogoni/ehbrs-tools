# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos2
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
