# frozen_string_literal: true

require 'eac_ruby_base0/patches'
require 'eac_ruby_utils/fs/clearable_directory'
require 'ehbrs/music/album'

module Ehbrs
  class Runner
    class Music
      class Selected
        DEFAULT_TRAVERSER_RECURSIVE = true

        enable_jobs_runner
        runner_with :help, :filesystem_traverser do
          desc 'Seleciona álbuns de música.'
          arg_opt '-b', '--build-dir', 'Constrói diretório de músicas selecionadas.'
        end

        def run
          infov 'Recursive', traverser_recursive
          run_jobs :show, :build
        end

        private

        def build
          infom 'Building...'
          build_dir.clear
          selected_albums.each do |album|
            ::EacRubyUtils::Envs.local.command('ln', '-s', album.path,
                                               build_dir.join(album.id)).system!
          end
        end

        def build_dir_uncached
          parsed.build_dir.if_present { |v| ::EacRubyUtils::Fs::ClearableDirectory.new(v) }
        end

        def run_build?
          build_dir.present?
        end

        def selected_albums_uncached
          infom 'Searching selected albums...'
          @selected = []
          run_filesystem_traverser
          @selected.sort
        end

        def show
          infov 'Albums found', selected_albums.count
          selected_albums.each do |album|
            puts album.to_label
          end
        end

        def traverser_check_directory(path)
          @selected << ::Ehbrs::Music::Album.new(path) if path.join('.selected').exist?
        end
      end
    end
  end
end
