# frozen_string_literal: true

require 'eac_ruby_base0/core_ext'
require 'ehbrs/executables'
require 'ehbrs_ruby_utils/videos/container'
require 'ehbrs_ruby_utils/videos/convert_job'

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Languages
          runner_with :help, :filesystem_traverser do
            desc 'Lê e modifica trilhas com idiomas de um vídeo.'
            bool_opt '-a', '--audios', 'Seleciona áudios.'
            bool_opt '-d', '--delete', 'Remove trilhas selecionadas.'
            bool_opt '-e', '--extract', 'Extrai trilhas selecionadas'
            arg_opt '-k', '--keep', 'Mantém legendas com o idioma especificado.', repeat: true
            bool_opt '-s', '--subtitles', 'Seleciona legendas.'
          end

          def keep_languages?
            keep_languages.any?
          end

          delegate :delete?, :extract?, to: :parsed

          def run
            infov 'Keep', keep_languages
            all_languages_banner
          end

          def keep_languages
            parsed.keep.map(&:strip).compact_blank
          end

          def include_audios?
            parsed.audios?
          end

          def include_subtitles?
            parsed.subtitles?
          end

          def traverser_check_file(file)
            @files << ::Ehbrs::Tools::Runner::Videos::Languages::FileRunner.new(self, file)
          end

          private

          def all_languages_uncached
            ::Set.new(files.flat_map(&:languages)).to_a.sort
          end

          def all_languages_banner
            infov 'Languages', all_languages.count
            all_languages.each do |language|
              infov '  * ', language.to_label
            end
          end

          def files_uncached
            @files = []
            run_filesystem_traverser
            @files
          end

          require_sub __FILE__
        end
      end
    end
  end
end
