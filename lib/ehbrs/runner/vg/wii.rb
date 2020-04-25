# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/fs/traversable'
require 'ehbrs/vg/wii/file_move'
require 'ehbrs/vg/wii/game_file'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Vg < ::EacRubyUtils::Console::DocoptRunner
      class Wii < ::EacRubyUtils::Console::DocoptRunner
        include ::EacCli::DefaultRunner
        include ::EacRubyUtils::Fs::Traversable

        runner_definition do
          desc 'Manipulação de imagens de jogo Wii.'
          bool_opt '-R', '--recursive', 'Busca arquivos recursivamente.'
          bool_opt '-d', '--dump', 'Mostra todos os atributos do jogo.'
          arg_opt '-m', '--move', 'Move o arquivo.'
          bool_opt '-c', '--confirm', 'Confirma o movimento do arquivo.'
          pos_arg 'paths', repeat: true
        end

        def run
          infov 'Recursive?', traverser_new.recursive?
          options.fetch('<paths>').each do |path|
            traverser_check_path(path)
          end
        end

        private

        def confirm?
          options.fetch('--confirm')
        end

        def dump(game)
          return unless options.fetch('--dump')

          game.properties.each do |name, value|
            infov "  * #{name}", value
          end
        end

        def move(game)
          return if move_arg.blank?

          file_move = ::Ehbrs::Vg::Wii::FileMove.new(game, game.format(move_arg))
          infov '  * Target path',
                file_move.target.to_s.colorize(file_move.change? ? :light_white : :light_black)
          file_move.run if confirm?
        end

        def move_arg
          options.fetch('--move')
        end

        def traverser_recursive
          options.fetch('--recursive')
        end

        def traverser_check_file(path)
          game = ::Ehbrs::Vg::Wii::GameFile.new(path)
          return unless game.valid?

          infom game.wit_path
          dump(game)
          move(game)
        end
      end
    end
  end
end
