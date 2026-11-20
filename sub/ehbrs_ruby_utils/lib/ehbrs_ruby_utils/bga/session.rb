# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Session < ::Aranha::Selenium::Session
      include ::EhbrsRubyUtils::Bga::Urls

      MESSAGE_ID = 'head_infomsg_1'

      # @!method initialize(username, password)
      #   @param username [String]
      #   @param password [String]
      common_constructor :username, :password, super_args: -> { [{ driver: :chrome }] }

      # @return [EhbrsRubyUtils::Bga::Session::Player]
      def player(id)
        ::EhbrsRubyUtils::Bga::Session::Player.new(self, id)
      end

      # @return [String, nil]
      def message_info
        find_or_not_element(id: MESSAGE_ID).if_present { |v| v.text.strip }
      end

      require_sub __FILE__, include_modules: true, require_mode: :kernel
    end
  end
end
