# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      module SkipTrophies
        TROPHY_SKIP_BUTTON_XPATH = '//*[@id = "splashedNotifications_overlay"]' \
                                   '//*[starts-with(@id, "continue_btn_")]'
        TROPHY_SKIP_TIMEOUT = 5

        # @param &block [Proc]
        # @return [Selenium::WebDriver::Error::TimeoutError, nil]
        def on_rescue_timeout(&block)
          block.call
          nil
        rescue ::Selenium::WebDriver::Error::TimeoutError => e
          e
        end

        def on_skip_trophies(...)
          error = on_rescue_timeout(...)
          return unless error
          raise error unless skip_trophy_overlay?

          skip_trophies
        end

        def skip_trophies
          loop do
            wait_for_click({ xpath: TROPHY_SKIP_BUTTON_XPATH }, TROPHY_SKIP_TIMEOUT)
          rescue ::Selenium::WebDriver::Error::TimeoutError
            break
          end
        end

        # @return [Boolean]
        def skip_trophy_overlay?
          find_or_not_element(xpath: TROPHY_SKIP_BUTTON_XPATH).present?
        end
      end
    end
  end
end
