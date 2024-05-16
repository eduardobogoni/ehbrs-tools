# frozen_string_literal: true

require 'eac_ruby_base0/core_ext'
require 'ehbrs_ruby_utils/music/sort/commands/dump'
require 'ehbrs_ruby_utils/music/sort/commands/load'
require 'ehbrs_ruby_utils/music/sort/commands/shuffle'

module Ehbrs
  module Tools
    class Runner
      class Music
        class Sort
          runner_with :help do
            desc 'Ordena arquivos/diretórios prefixando-os.'
            bool_opt '-c', '--confirm', 'Confirm changes.'
            arg_opt '-p', '--path', 'Path to the directory.'
            pos_arg :command
          end

          delegate :command, :confirm?, to: :parsed

          COMMANDS = { 'load' => ::EhbrsRubyUtils::Music::Sort::Commands::Load,
                       'shuffle' => ::EhbrsRubyUtils::Music::Sort::Commands::Shuffle,
                       'dump' => ::EhbrsRubyUtils::Music::Sort::Commands::Dump }.freeze

          def run
            banner
            if command_class
              command_class.new(path, confirm?)
            else
              fatal_error "Unknown command: \"#{command}\" (Valid: #{COMMANDS.keys.join(', ')})"
            end
          end

          # @return [String]
          def help_extra_text
            help_list_section('Commands', COMMANDS.keys)
          end

          private

          def command_class_uncached
            COMMANDS[parsed.command]
          end

          def banner
            infov('Path', path)
            infov('Command', command)
            infov('Confirm', confirm?)
          end

          def path_uncached
            (parsed.path || '.').to_pathname.expand_path
          end
        end
      end
    end
  end
end
