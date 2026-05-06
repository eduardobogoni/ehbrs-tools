# frozen_string_literal: true

module EhbrsRubyUtils
  module Booking
    module Processors
      class List < ::EhbrsRubyUtils::Aranha::AccommodationsProcessor
        CLOSE_BANNER_XPATH = '//button[@aria-label = "Ignorar informações de login."]'
        MORE_RESULTS_XPATH = '//*[text() = "Ver mais resultados"]'

        protected

        # @return [Boolean]
        def all_data_loaded?
          p = parser
          p.data.fetch(:declared_count).if_present(false) do |v|
            p.data.fetch(:accommodations).count >= v
          end
        end

        def click_more_results
          more_results_button.click
        end

        def close_banner
          close_banner_button.click
        end

        # @return [Aranha::Selenium::Session::Element]
        def close_banner_button
          session.element(xpath: CLOSE_BANNER_XPATH)
        end

        # @return [Aranha::Selenium::Session::Element]
        def more_results_button
          session.element(xpath: MORE_RESULTS_XPATH)
        end

        # @return [void]
        def scroll_down
          close_banner
          click_more_results
          super
        end

        # @return [Aranha::Selenium::Session]
        memoize def session
          ::Aranha::Selenium::Session.new(driver: :chrome)
        end

        require_sub __FILE__, require_mode: :kernel
      end
    end
  end
end
