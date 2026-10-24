# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      module CookiesConsent
        REJECT_ALL_BUTTON_SELECTOR = { id: 'didomi-notice-disagree-button' }.freeze
        REJECT_ALL_BUTTON_TIMEOUT = 5

        # @return [void]
        def dismiss_cookies_banner
          wait_for_click(REJECT_ALL_BUTTON_SELECTOR, REJECT_ALL_BUTTON_TIMEOUT)
        rescue ::Selenium::WebDriver::Error::TimeoutError
          nil
        end
      end
    end
  end
end
