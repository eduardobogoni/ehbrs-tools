# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos
    module Subtitles
      class Sanitize < ::EhbrsRubyUtils::Fs::ToFileFormat
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
