# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Music
        class LyricsBook
          runner_with :help, :output do
            arg_opt '-p', '--provider', 'Nome do provedor.',
                    default: ::EhbrsRubyUtils::Music::LyricsBook::DEFAULT_PROVIDER_NAME
            pos_arg :source_dir
          end

          def run
            start_banner
            run_output
          end

          def start_banner
            infov 'Source directory', book.source_dir
            infov 'Selected provider', book.provider
          end

          def book_uncached
            ::EhbrsRubyUtils::Music::LyricsBook.new(parsed.source_dir,
                                                    provider_name: parsed.provider)
          end

          def output_content
            book.output
          end
        end
      end
    end
  end
end
