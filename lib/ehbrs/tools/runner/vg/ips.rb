# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/fs/temp'
require 'ehbrs/executables'

module Ehbrs
  module Tools
    class Runner
      class Vg
        class Ips
          runner_with :help do
            desc 'Aplica patches IPS em roms.'
            arg_opt '-o', '--output-file', ' Saída no arquivo <output-file>.'
            bool_opt '-w', '--overwrite', 'Sobrescreve o arquivo de saída se existente.'
            pos_arg 'source-file'
            pos_arg 'ips-files', repeat: true
          end

          def run
            validate
            start_banner
            run_patches
            infov 'Concluído'
          end

          private

          def on_temp_files
            ::EacRubyUtils::Fs::Temp.on_file do |input|
              ::EacRubyUtils::Fs::Temp.on_file do |output|
                yield TempFiles.new(source_file, input, output)
              end
            end
          end

          def run_patch(source_path, ips_path, output_path)
            ::Ehbrs::Executables.flips.command
                                .append(['--apply', ips_path, source_path, output_path]).system!
          end

          def run_patches
            on_temp_files do |temp|
              ips_files.each do |ips_file|
                run_patch(temp.input, ips_file, temp.output)
                temp.swap
              end
              temp.move_result_to(output_file)
            end
          end

          def source_file
            parsed.source_file.to_pathname
          end

          def start_banner
            infov 'Source file', source_file
            infov 'Output file', output_file
            infov 'IPS files', ips_files.count
            ips_files.each { |ips_file| infov '  * ', ips_file }
          end

          def ips_files
            parsed.ips_files.map(&:to_pathname)
          end

          def output_file
            parsed.output_file.to_pathname || default_output_file
          end

          def default_output_file
            ips_files.last.parent.join(
              ips_files.map { |f| f.basename('.*').to_path }.join('_') + source_file.extname
            )
          end

          def validate
            validate_source_file
            ips_files.each { |ips_file| validate_ips_file(ips_file) }
            validate_output_file
          end

          def validate_source_file
            return if source_file.exist?

            fatal_error("Arquivo fonte \"#{source_file}\" não existe")
          end

          def validate_ips_file(ips_file)
            return if ::File.exist?(ips_file)

            fatal_error("Arquivo IPS \"#{ips_file}\" não existe")
          end

          def validate_output_file
            return unless output_file.exist?
            return if parsed.overwrite?

            fatal_error("Arquivo de saída \"#{output_file}\" já existe")
          end

          class TempFiles
            common_constructor :initial, :temp0, :temp1

            def input
              swaped? ? temp0 : initial
            end

            def move_result_to(dest)
              return unless swaped?

              ::FileUtils.mv(temp0.to_path, dest.to_path)
            end

            def output
              temp1
            end

            def swap
              temp0_current = temp0
              self.temp0 = temp1
              self.temp1 = temp0_current
              @swaped = true
            end

            def swaped?
              @swaped ? true : false
            end
          end
        end
      end
    end
  end
end
