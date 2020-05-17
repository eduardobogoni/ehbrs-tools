# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'ehbrs/videos/series/rename/file'
require 'ehbrs/videos/series/rename/file/options'
require 'ehbrs/videos/series/rename/results_builder'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Videos < ::EacRubyUtils::Console::DocoptRunner
      class Series < ::EacRubyUtils::Console::DocoptRunner
        class Rename < ::EacRubyUtils::Console::DocoptRunner
          include ::EacCli::DefaultRunner
          include ::EacRubyUtils::Fs::Traversable

          runner_definition do
            desc 'Renomeia arquivos de séries.'
            bool_opt '-r', '--recursive', 'Recursivo.'
            bool_opt '-c', '--confirm', 'Confirmação a renomeação.'
            arg_opt '-k', '--kernel', 'Determina o kernel para os nomes dos arquivos.'
            arg_opt '-E', '--extension', 'Substitui a extensão dos arquivos.'
            arg_opt '-e', '--episode-increment', 'Aumenta o número do episódio.'
            pos_arg 'paths', repeat: true, optional: true
          end

          def run
            banner
            show_results
            rename_files
          end

          def banner
            infov 'Paths', paths.count
            infov 'Files found', files.count
          end

          def files_uncached
            @files = []
            paths.each { |path| traverser_check_path(path) }
            @files
          end

          def paths
            options.fetch('<paths>').if_present(['.'])
          end

          def traverser_recursive
            options.fetch('--recursive')
          end

          def traverser_check_file(path)
            @files << ::Ehbrs::Videos::Series::Rename::File.new(path, series_file_options)
          end

          def series_file_options_uncached
            ::Ehbrs::Videos::Series::Rename::File::Options.new(options)
          end

          def show_results
            ::Ehbrs::Videos::Series::Rename::ResultsBuilder.new(files).show(0)
          end

          def rename_files
            return unless series_file_options.confirm

            infom 'Renaming files...'
            files.each(&:rename)
          end
        end
      end
    end
  end
end
