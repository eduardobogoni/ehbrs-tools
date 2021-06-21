# frozen_string_literal: true

require 'eac_ruby_utils/envs'
require 'eac_ruby_utils/fs/clearable_directory'
require 'ehbrs/core_ext'

module Ehbrs
  class Runner
    class Fs
      class Selected
        DEFAULT_TRAVERSER_RECURSIVE = true

        enable_jobs_runner
        runner_with :help, :filesystem_traverser do
          desc 'Seleciona diretórios.'
          arg_opt '-b', '--build-dir', 'Constrói diretório alvo.'
        end

        def run
          infov 'Recursive', traverser_recursive
          run_jobs :show, :build
        end

        protected

        def build_selected_directory(path)
          path
        end

        def directory_label(directory)
          directory.to_s
        end

        def directory_target_basename(directory)
          directory.basename.to_path
        end

        private

        def build
          infom 'Building...'
          build_dir.clear
          selected_directories.each do |directory|
            ::EacRubyUtils::Envs.local.command(
              'ln', '-s', directory.to_path,
              build_dir.join(directory_target_basename(directory))
            ).system!
          end
        end

        def build_dir_uncached
          parsed.build_dir.if_present { |v| ::EacRubyUtils::Fs::ClearableDirectory.new(v) }
        end

        def run_build?
          build_dir.present?
        end

        def selected_directories_uncached
          infom 'Searching selected directories...'
          @selected = []
          run_filesystem_traverser
          @selected.sort
        end

        def show
          infov 'Directories found', selected_directories.count
          selected_directories.each do |directory|
            puts directory_label(directory)
          end
        end

        def traverser_check_directory(path)
          @selected << build_selected_directory(path) if path.join('.selected').exist?
        end
      end
    end
  end
end
