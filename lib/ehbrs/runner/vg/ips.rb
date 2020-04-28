# frozen_string_literal: true

require 'eac_cli/runner'
require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'ehbrs/executables'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Vg < ::EacRubyUtils::Console::DocoptRunner
      class Ips < ::EacRubyUtils::Console::DocoptRunner
        include ::EacCli::DefaultRunner

        runner_definition do
          desc 'Aplica patches IPS em roms.'
          arg_opt '-o', '--output-file', ' Saída no arquivo <output-file>.'
          bool_opt '-w', '--overwrite', 'Sobrescreve o arquivo de saída se existente.'
          pos_arg 'source-file'
          pos_arg 'ips-file'
        end

        def run
          validate
          start_banner
          run_patch
        end

        private

        def run_patch
          ::Ehbrs::Executables.flips.command
                              .append(['--apply', ips_file, source_file, output_file]).system!
        end

        def source_file
          options.fetch('<source-file>').to_pathname
        end

        def start_banner
          infov 'Source file', source_file
          infov 'IPS file', ips_file
          infov 'Output file', output_file
        end

        def ips_file
          options.fetch('<ips-file>').to_pathname
        end

        def output_file
          options.fetch('--output-file').to_pathname || default_output_file
        end

        def default_output_file
          ips_file.parent.join(
            ips_file.basename('.*').to_path + source_file.extname
          )
        end

        def validate
          validate_source_file
          validate_ips_file
          validate_output_file
        end

        def validate_source_file
          return if source_file.exist?

          fatal_error("Arquivo fonte \"#{source_file}\" não existe")
        end

        def validate_ips_file
          return if ips_file.exist?

          fatal_error("Arquivo IPS \"#{ips_file}\" não existe")
        end

        def validate_output_file
          return unless output_file.exist?
          return if options.fetch('--overwrite')

          fatal_error("Arquivo de saída \"#{output_file}\" já existe")
        end
      end
    end
  end
end
