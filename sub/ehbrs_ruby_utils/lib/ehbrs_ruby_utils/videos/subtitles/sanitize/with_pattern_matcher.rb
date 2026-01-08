# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos
    module Subtitles
      class Sanitize < ::EhbrsRubyUtils::Fs::ToFileFormat
        class WithPatternMatcher
          common_constructor :pattern

          def process(line)
            line.gsub(pattern, '')
          end
        end
      end
    end
  end
end
