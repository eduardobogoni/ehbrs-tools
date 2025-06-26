# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Vg
        class Ps2
          class Rename
            DEFAULT_TRAVERSER_RECURSIVE = true

            runner_with :help, :filesystem_renamer do
              desc 'Renomeia ISOS de PS2'
            end

            # @return [void]
            def run
              run_filesystem_renamer
            end

            private

            # @return [Class]
            def file_class
              ::EhbrsRubyUtils::Vg::Ps2::IsoFile
            end
          end
        end
      end
    end
  end
end
