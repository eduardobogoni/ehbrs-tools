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
        end

        private

        def run_patch
          ::Ehbrs::Executables.floating_ips.command
                              .append(['--apply', ips_file, source_file, output_file]).system!
        end

        def source_file
          options.fetch('<source-file>')
        end

        def start_banner
          infov 'Source file', source_file
          infov 'IPS file', ips_file
          infov 'Output file', output_file
        end

        def ips_file
          options.fetch('<ips-file>')
        end

        def output_file
          options.fetch('--output-file') || default_output_file
        end

        def default_output_file
          ::File.join(
            ::File.dirname(ips_file),
            ::File.basename(ips_file, '.*') + ::File.extname(source_file)
          )
        end

        def validate
          validate_source_file
          validate_ips_file
          validate_output_file
          start_banner
          run_patch
        end

        def validate_source_file
          return if ::File.exist?(source_file)

          fatal_error("Arquivo fonte \"#{source_file}\" não existe")
        end

        def validate_ips_file
          return if ::File.exist?(ips_file)

          fatal_error("Arquivo IPS \"#{ips_file}\" não existe")
        end

        def validate_output_file
          return unless ::File.exist?(output_file)
          return if options.fetch('--overwrite')

          fatal_error("Arquivo de saída \"#{output_file}\" já existe")
        end
      end
    end
  end
end
