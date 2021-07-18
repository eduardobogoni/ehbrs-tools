# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs/telegram/message_sending'

module Ehbrs
  module Tools
    class Runner
      class Telegram
        class SendMessage
          runner_with :help do
            desc 'Envia mensagens Telegram.'
            pos_arg :message
            pos_arg :recipients_ids, repeat: true
          end

          delegate :run, to: :message_sending

          private

          def message_sending_uncached
            parsed.recipients_ids
                  .inject(::Ehbrs::Telegram::MessageSending.new) { |a, e| a.recipient_id(e) }
                  .bot_token(runner_context.call(:bot_token))
                  .message(parsed.message)
          end
        end
      end
    end
  end
end
