# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs_ruby_utils/videos/container/file'
require 'eac_ruby_utils/yaml'

module Ehbrs
  class Runner
    class Videos
      class Probe
        runner_with :help, :output_file do
          desc 'FFProbe em um arquivo de vídeo.'
          pos_arg :file_path
        end

        def run
          run_output
        end

        def output_content
          ::EacRubyUtils::Yaml.dump(container_file.info.to_h)
        end

        private

        def container_file_uncached
          ::EhbrsRubyUtils::Videos::Container::File.new(parsed.file_path)
        end
      end
    end
  end
end
