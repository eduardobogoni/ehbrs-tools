# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/fs/to_file_format'

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
