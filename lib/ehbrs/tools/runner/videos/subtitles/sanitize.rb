# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Subtitles
          class Sanitize
            runner_with :help, :filesystem_traverser do
              desc 'Conserta legendas.'
            end

            def keep_languages?
              keep_languages.present?
            end

            delegate :delete?, :extract?, to: :parsed

            def run
              run_filesystem_traverser
            end

            def traverser_check_file(file)
              sub = ::EhbrsRubyUtils::Videos::Subtitles::Sanitize.new(file)
              return unless sub.subtitle?

              infov 'Subtitle found', sub.file
              sub.run
            end
          end
        end
      end
    end
  end
end
