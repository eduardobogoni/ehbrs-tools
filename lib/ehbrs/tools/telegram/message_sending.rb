# frozen_string_literal: true

module Ehbrs
  module Tools
    module Telegram
      class MessageSending
        acts_as_immutable
        immutable_accessor :bot_token, :message
        immutable_accessor :recipient_id, type: :array

        def run
          ::Telegram::Bot::Client.run(prop(:bot_token)) do |bot|
            prop(:recipient_ids).each do |recipient_id|
              bot.api.sendMessage(chat_id: recipient_id, text: prop(:message))
            end
          end
        end

        private

        def prop(attribute)
          r = send(attribute)
          return r if r.present?

          raise "Attribute #{attribute} is blank"
        end
      end
    end
  end
end
