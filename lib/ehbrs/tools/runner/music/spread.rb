# frozen_string_literal: true

require 'ehbrs_ruby_utils/music/ous/album'
require 'ehbrs_ruby_utils/circular_list_spreader'
require 'ehbrs/tools/runner/fs/selected'

module Ehbrs
  module Tools
    class Runner
      class Music
        class Spread
          runner_with :help do
            bool_opt '-i', '--ids', 'Escreve IDs em STDOUT no lugar de labels em STDERR.'
            bool_opt '-v', '--verbose'
            pos_arg :albums, repeat: true
          end

          def run
            start_info
            show_results
          end

          def spreader_uncached
            ::EhbrsRubyUtils::CircularListSpreader.new(albums)
          end

          protected

          # @return [Array<EhbrsRubyUtils::Music::Ous::Album>]
          def albums_uncached
            parsed.albums.map do |path|
              ::EhbrsRubyUtils::Music::Ous::Album.new(path)
            end
          end

          # @return [void]
          def albums_info
            infov 'Albums', albums.count
            albums.each do |album|
              infov '  * ', album
            end
          end

          # @return [void]
          def show_results
            spreader.result.each do |album|
              if parsed.ids?
                out("#{album.id}\n")
              else
                puts album.to_label
              end
            end
          end

          # @return [void]
          def start_info
            return unless parsed.verbose?

            albums_info
          end
        end
      end
    end
  end
end
