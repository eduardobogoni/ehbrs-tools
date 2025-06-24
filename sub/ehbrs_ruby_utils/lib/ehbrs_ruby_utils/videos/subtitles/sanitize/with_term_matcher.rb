# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos
    module Subtitles
      class Sanitize < ::EhbrsRubyUtils::Fs::ToFileFormat
        class WithTermMatcher
          common_constructor :term

          def process(lines)
            lines.map(&:downcase).any? { |line| line.include?(term) } ? nil : lines
          end
        end
      end
    end
  end
end
