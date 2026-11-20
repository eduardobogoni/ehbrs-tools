# frozen_string_literal: true

module EhbrsRubyUtils
  module Gjt1
    class Manager
      include ::Singleton

      acts_as_abstract :bga_username, :bga_password, :whatsapp_recipient

      %w[beginning ending].each do |type|
        # @param table [EhbrsRubyUtils::Bga::Table]
        # @return [void]
        define_method "bga_table_#{type}_notify" do |table|
          whatsapp_formatter_send(
            ::EhbrsRubyUtils::Bga::Table::WhatsappFormatters.const_get(type.camelize),
            table
          )
        end
      end

      # @param game_statistics [EhbrsRubyUtils::Bga::GameStatistics]
      # @return [void]
      def bga_game_statistics_notify(game_statistics)
        whatsapp_formatter_send(
          ::EhbrsRubyUtils::Bga::GameStatistics::WhatsappFormatter, game_statistics
        )
      end

      # @yieldparam bga_session [EhbrsRubyUtils::Bga::Session]
      # @return [Object]
      # @raise [RuntimeError]
      def on_bga_logged_session(&block)
        new_bga_session.quit_on_end do |bga_session|
          bga_session.on_logged { block.call(bga_session) }
        end
      end

      # @return [EhbrsRubyUtils::Bga::Session] Cria uma nova sessão BGA.
      def new_bga_session
        ::EhbrsRubyUtils::Bga::Session.new(bga_username, bga_password)
      end

      # @param message [String]
      # @param image_path [Pathname]
      # @return [void]
      def whatsapp_send(message, image_path = nil)
        ::EhbrsRubyUtils::Mudslide::Message.new.text(message).image_path(image_path)
          .recipient(whatsapp_recipient).deliver
      end

      private

      # @return [void]
      def whatsapp_formatter_send(formatter_class, formatter_owner)
        formatter = formatter_class.new(formatter_owner)
        whatsapp_send(formatter.to_s, formatter.image_local_path)
      end
    end
  end
end
