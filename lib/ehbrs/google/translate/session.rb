# frozen_string_literal: true

require 'aranha/selenium/session'

module Ehbrs
  module Google
    module Translate
      class Session
        START_URL = 'https://translate.google.com.br/#view=home&op=docs&sl=en&tl=pt'
        CLOSE_POPUP_CSS = '.dismiss-button'
        FILE_INPUT_XPATH = '//*[@id = "tlid-file-input"]'
        SUBMIT_XPATH = '//form[@action="//translate.googleusercontent.com/translate_f"]' \
                       '//input[@type="submit"]'
        RESULT_XPATHS = [
          '//script[contains(@src, "https://translate.google.com/translate_a")]',
          '/html/body/pre'
        ].freeze

        attr_reader :sub

        def initialize
          @sub = ::Aranha::Selenium::Session.new
        end

        def translate(source_document_path)
          go_to_upload_form
          input_file(source_document_path)
          close_changes_alert_popup
          click_on_translate_button
          wait_for_load_translation
          sub.current_source
        end

        private

        def go_to_upload_form
          sub.navigate.to START_URL
          sub.wait_for_element(xpath: FILE_INPUT_XPATH)
        end

        def input_file(source_document_path)
          sub.find_element(xpath: FILE_INPUT_XPATH).send_keys(source_document_path)
        end

        def click_on_translate_button
          sub.wait_for_click(xpath: SUBMIT_XPATH)
        end

        def close_changes_alert_popup
          sub.wait_for_click(css: CLOSE_POPUP_CSS)
        end

        def wait_for_load_translation
          sub.wait.until do
            RESULT_XPATHS.any? { |xpath| sub.find_elements(xpath: xpath).size.positive? }
          end
        end
      end
    end
  end
end
