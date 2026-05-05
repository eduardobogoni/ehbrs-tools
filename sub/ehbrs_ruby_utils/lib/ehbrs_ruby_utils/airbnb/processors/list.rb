# frozen_string_literal: true

module EhbrsRubyUtils
  module Airbnb
    module Processors
      class List
        enable_memoized
        common_constructor :url

        # @return [Enumerable<Hash>]
        def accommodations
          current_url = url
          index = 0
          r = []
          while current_url.present?
            accommodations, current_url, index = page_accommodations(current_url, index)
            r += accommodations
          end
          r
        end

        # @return [Integer]
        def declared_count
          @declared_count || raise('@declared_count is blank')
        end

        protected

        # @param current_url [Addressable::URI]
        # @param index [Integer]
        # @return [Array]
        def page_accommodations(current_url, index)
          page = ::EhbrsRubyUtils::Airbnb::Processors::Page.new(current_url, session, index)
          @declared_count ||= page.declared_count
          [page.accommodations, page.next_page_url, index + 1]
        end

        # @return [Aranha::Selenium::Session]
        memoize def session
          ::Aranha::Selenium::Session.new(driver: :chrome)
        end
      end
    end
  end
end
