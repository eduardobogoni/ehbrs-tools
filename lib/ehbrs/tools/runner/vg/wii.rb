# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Vg
        class Wii
          include ::EacFs::Traversable

          runner_with :help do
            desc 'Manipulação de imagens de jogo Wii.'
            bool_opt '-R', '--recursive', 'Busca arquivos recursivamente.'
            bool_opt '-d', '--dump', 'Mostra todos os atributos do jogo.'
            arg_opt '-m', '--move', 'Move o arquivo.'
            bool_opt '-c', '--confirm', 'Confirma o movimento do arquivo.'
            pos_arg 'paths', repeat: true
          end

          def run
            infov 'Recursive?', traverser_new.recursive?
            parsed.paths.each do |path|
              traverser_check_path(path)
            end
          end

          private

          def confirm?
            parsed.confirm?
          end

          def dump(game)
            return unless parsed.dump?

            game.properties.each do |name, value|
              infov "  * #{name}", value
            end
          end

          def move(game)
            return if move_arg.blank?

            file_move = ::EhbrsRubyUtils::Vg::Wii::FileMove.new(game, game.format(move_arg))
            infov '  * Target path',
                  file_move.target.to_s.colorize(file_move.change? ? :light_white : :light_black)
            file_move.run if confirm?
          end

          def move_arg
            parsed.move
          end

          def traverser_recursive
            parsed.recursive
          end

          def traverser_check_file(path)
            game = ::EhbrsRubyUtils::Vg::Wii::GameFile.new(path)
            return unless game.valid?

            infom game.wit_path
            dump(game)
            move(game)
          end
        end
      end
    end
  end
end
