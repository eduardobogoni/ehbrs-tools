# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Vg
        class Patch
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
                yield ::EhbrsRubyUtils::Vg::Patchers::TempFiles.new(source_file, input, output)
              end
            end
          end

          def run_patch(source_path, ips_path, output_path)
            ::EhbrsRubyUtils::Vg::Patchers::ApplierFactory.new(ips_path)
              .apply(source_path, output_path)
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
        end
      end
    end
  end
end
