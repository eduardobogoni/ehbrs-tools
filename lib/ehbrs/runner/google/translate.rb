# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'ehbrs/google/translate/session'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Google
      class Translate
        runner_with :help do
          desc 'Traduz um documento com Google Translate.'
          arg_opt '-o', '--output-file', 'Salva saída em <output-file>.'
          bool_opt '-w', '--overwrite', 'Permite sobreescrever arquivo de saída.'
          pos_arg 'source-file'
        end

        def run
          start_banner
          validate
          if output_to_stdout?
            out(translated_content)
          else
            ::File.write(output_file, translated_content)
          end
          success 'Concluído'
        end

        def start_banner
          infov 'Source file', source_file
          infov 'Target file', output_file
        end

        def translated_content_uncached
          session.translate(source_file)
        end

        delegate :source_file, to: :parsed

        def output_file
          parsed.output_file || default_output_file
        end

        def default_output_file
          ::File.join(
            ::File.dirname(source_file),
            ::File.basename(source_file, '.*') + '_translated.html'
          )
        end

        def session_uncached
          ::Ehbrs::Google::Translate::Session.new
        end

        def validate
          validate_source_file
          validate_output_file
          validate_output_content
        end

        def validate_source_file
          return if ::File.exist?(source_file)

          fatal_error "Source file \"#{source_file}\" does not exist"
        end

        def validate_output_file
          return if output_to_stdout?
          return unless ::File.exist?(output_file)
          return if parsed.overwrite?

          fatal_error "Output file \"#{output_file}\" already exists"
        end

        def validate_output_content
          return if translated_content.present?

          fatal_error 'Output content is empty'
        end

        def output_to_stdout?
          output_file == '-'
        end
      end
    end
  end
end
