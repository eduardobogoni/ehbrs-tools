# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs/tools/instance'

module Ehbrs
  module Tools
    class Runner
      class Telegram
        require_sub __FILE__

        runner_with :help, :subcommands do
          desc 'Operações com Telegram.'
          arg_opt '-b', '--bot-token', 'Token do bot Telegram.'
          subcommands
        end

        def bot_token
          parsed.bot_token || default_bot_token
        end

        def default_bot_token
          ::Ehbrs::Tools.instance.read_entry(:telegram_bot_token)
        end
      end
    end
  end
end
