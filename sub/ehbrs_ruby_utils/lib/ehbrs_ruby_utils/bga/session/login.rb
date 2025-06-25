# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      module Login
        LOGIN_PATH = 'account'
        USERNAME_INPUT_ID = 'username_input'
        PASSWORD_INPUT_ID = 'password_input'
        SUBMIT_ID = 'login_button'

        # @return [Boolean]
        def login # rubocop:disable Naming/PredicateMethod
          navigate_to_login_page
          input_username
          input_password
          submit_login
          logged?
        end

        def login_url
          build_url(LOGIN_PATH)
        end

        private

        def navigate_to_login_page
          navigate.to(login_url)
        end

        def input_username
          wait_for_element(id: USERNAME_INPUT_ID).send_keys(username)
        end

        def input_password
          wait_for_element(id: PASSWORD_INPUT_ID).send_keys(password)
        end

        def submit_login
          wait_for_click(id: SUBMIT_ID)
        end
      end
    end
  end
end
