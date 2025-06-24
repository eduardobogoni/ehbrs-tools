# frozen_string_literal: true

module EhbrsRubyUtils
  module Booking
    module Processors
      class List
        enable_simple_cache
        common_constructor :url

        CLOSE_BANNER_XPATH = '//button[@aria-label = "Ignorar informações de login."]'
        MORE_RESULTS_XPATH = '//*[text() = "Ver mais resultados"]'
        SCROLL_DOWN_STEP = 500

        # @return [Array]
        def accommodations
          data.fetch(:accommodations).map { |a| build_accommodation(a) }
        end

        # @return [Integer]
        def declared_count
          data.fetch(:declared_count)
        end

        protected

        # @return [Boolean]
        def all_accommodations_reached?
          p = parser
          p.data.fetch(:accommodations).count >= p.data.fetch(:declared_count)
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

        def data_uncached
          session.navigate.to url
          session.wait(5.minutes).until do
            close_banner
            click_more_results
            scroll_down
            all_accommodations_reached?
          end
          parser.data
        end

        # @return [Aranha::Selenium::Session::Element]
        def more_results_button
          session.element(xpath: MORE_RESULTS_XPATH)
        end

        def parser
          ::EhbrsRubyUtils::Booking::Parsers::List.from_string(session.current_source)
        end

        # @return [Aranha::Selenium::Session]
        def session_uncached
          ::Aranha::Selenium::Session.new
        end

        def scroll_down
          session.scroll_down_by(SCROLL_DOWN_STEP)
        end

        require_sub __FILE__, require_mode: :kernel
      end
    end
  end
end
