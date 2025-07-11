# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Series
          class Rename
            include ::EacFs::Traversable

            runner_with :help do
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
              parsed.paths.if_present(['.'])
            end

            def traverser_recursive
              parsed.recursive
            end

            def traverser_check_file(path)
              @files << ::EhbrsRubyUtils::Videos::Series::Rename::File
                          .new(path, series_file_options)
            end

            def series_file_options_uncached
              ::EhbrsRubyUtils::Videos::Series::Rename::File::Options.new(parsed)
            end

            def show_results
              ::EhbrsRubyUtils::Videos::Series::Rename::ResultsBuilder.new(files).show(0)
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
end
