# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Probe
          runner_with :help, :output do
            desc 'FFProbe em um arquivo de vídeo.'
            pos_arg :file_path
          end

          def run
            run_output
          end

          def output_content
            ::EacRubyUtils::Yaml.dump(container_file.probe_data)
          end

          private

          def container_file_uncached
            ::EhbrsRubyUtils::Videos::File.new(parsed.file_path)
          end
        end
      end
    end
  end
end
