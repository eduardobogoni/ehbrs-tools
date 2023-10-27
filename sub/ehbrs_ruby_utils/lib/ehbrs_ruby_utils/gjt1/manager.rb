# frozen_string_literal: true

require 'ehbrs_ruby_utils/bga/session'
require 'ehbrs_ruby_utils/executables'
require 'ehbrs_ruby_utils/mudslide/message'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Gjt1
    class Manager
      include ::Singleton
      acts_as_abstract :bga_usernam, :bga_password, :whatsapp_recipient

      %w[beginning ending].each do |type|
        # @param table [EhbrsRubyUtils::Bga::Table]
        # @return [void]
        define_method "bga_table_#{type}_notify" do |table|
          formatter = ::EhbrsRubyUtils::Bga::Table::WhatsappFormatters.const_get(type.camelize)
                        .new(table)
          whatsapp_send(formatter.to_s, formatter.image_local_path)
        end
      end

      def on_bga_logged_session(&block)
        bga_session = new_bga_session
        begin
          bga_session.on_logged { block.call(bga_session) }
        ensure
          bga_session.close
          bga_session = nil
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

      def mudslide_run(*args)
        ::EhbrsRubyUtils::Executables.mudslide.command(*args).system!
      end
    end
  end
end
