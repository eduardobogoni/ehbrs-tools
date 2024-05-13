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
            pos_arg :albums, repeat: true
          end

          def run
            spreader.result.each do |album|
              if parsed.ids?
                out("#{album.id}\n")
              else
                puts album.to_label
              end
            end
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
        end
      end
    end
  end
end
