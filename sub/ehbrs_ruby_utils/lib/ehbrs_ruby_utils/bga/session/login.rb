# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      module Login
        LOGIN_PATH = 'account'
        STEP1_SELECTOR = { css: '.bga-account-manager-form__step1' }.freeze
        STEP2_SELECTOR = { css: '.bga-account-manager-form__step2' }.freeze
        EMAIL_INPUT_SELECTOR = { css: "#{STEP1_SELECTOR[:css]} input[name=\"email\"]" }.freeze
        NEXT_BUTTON_SELECTOR = { css: "#{STEP1_SELECTOR[:css]} a.bga-button--blue" }.freeze
        PASSWORD_INPUT_SELECTOR = {
          css: "#{STEP2_SELECTOR[:css]} input[type=\"password\"]"
        }.freeze
        LOGIN_BUTTON_SELECTOR = { css: "#{STEP2_SELECTOR[:css]} a.bga-button--blue" }.freeze
        URL_LOGIN_PAGE_COMPONENT = 'page=login'

        # @return [Boolean]
        def login # rubocop:disable Naming/PredicateMethod
          navigate_to_login_page
          input_username
          submit_username
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
          dismiss_cookies_banner
        end

        def input_username
          wait_for_element(EMAIL_INPUT_SELECTOR).send_keys(username)
        end

        def submit_username
          wait_for_click(NEXT_BUTTON_SELECTOR)
        end

        def input_password
          wait_for_element(PASSWORD_INPUT_SELECTOR).send_keys(password)
        end

        # @return [void]
        def submit_login
          wait_for_click(LOGIN_BUTTON_SELECTOR)
          begin
            wait.until { current_url.exclude?(URL_LOGIN_PAGE_COMPONENT) }
          rescue ::Selenium::WebDriver::Error::TimeoutError
            nil
          end
        end
      end
    end
  end
end
