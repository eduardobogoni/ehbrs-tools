# frozen_string_literal: true

require 'eac_ruby_utils/envs'

require 'ehbrs/tools/core_ext'
require 'ehbrs_ruby_utils/fs/selected'

module Ehbrs
  module Tools
    class Runner
      class Fs
        class Selected
          enable_jobs_runner
          runner_with :confirmation, :help do
            desc 'Seleciona diretórios.'
            arg_opt '-b', '--build-dir', 'Constrói diretório alvo.'
            arg_opt '-f', '--filename', 'Nome do arquivo que anota o diretório como selecionado.',
                    default: ::EhbrsRubyUtils::Fs::Selected::DEFAULT_FILENAME

            pos_arg :root_path
          end

          def run
            infov 'Root path', selected.root_path
            infov 'Filename', selected.filename
            infov 'Build directory', build_dir.if_present('-')
            run_jobs :show, :build
          end

          protected

          def directory_label(directory)
            directory.to_s
          end

          def directory_target_basename(directory)
            ::EhbrsRubyUtils::Fs::Selected::Build::DEFAULT_TARGET_BASENAME_PROC.call(directory)
          end

          private

          def build
            infom "Building directory \"#{build_dir}\" with selected..."
            selected.build(build_dir, &method(:directory_target_basename)).perform
          end

          def build_dir_uncached
            parsed.build_dir.if_not_nil(&:to_pathname)
          end

          def run_build?
            build_dir.present? && confirm?('Build?')
          end

          def selected_directories_uncached
            infom 'Searching selected directories...'
            selected.found
          end

          def selected_uncached
            ::EhbrsRubyUtils::Fs::Selected.new(parsed.root_path, filename: parsed.filename)
          end

          def show
            infov 'Directories found', selected_directories.count
            selected_directories.each do |directory|
              puts directory_label(directory)
            end
          end
        end
      end
    end
  end
end
