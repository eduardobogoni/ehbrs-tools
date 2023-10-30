# frozen_string_literal: true

require 'avm/file_formats/utf8_assert'
require 'ehbrs_ruby_utils/fs/to_file_format'
require 'ehbrs_ruby_utils/fs/to_windows_pt_br'

module EhbrsRubyUtils
  module Videos
    module Subtitles
      class Sanitize < ::EhbrsRubyUtils::Fs::ToFileFormat
        require_sub __FILE__

        def run
          sanitize_content
          convert_to_windows_ptbr
        end

        def subtitle?
          text? && file.extname == '.srt'
        end

        private

        def convert_to_windows_ptbr
          ::EhbrsRubyUtils::Fs::ToWindowsPtBr.convert_self(file)
        end

        def sanitize_content
          ::Avm::FileFormats::Utf8Assert.assert_files([file]) do
            sanitize_content_on_utf8
          end
        end

        def sanitize_content_on_utf8
          input = file.read
          output = ::EhbrsRubyUtils::Videos::Subtitles::Sanitize::ContentSanitizer.new(input).output
          file.write(output) if input != output
        end
      end
    end
  end
end
