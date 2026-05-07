# frozen_string_literal: true

module EhbrsRubyUtils
  module Airbnb
    module Processors
      class Page < ::EhbrsRubyUtils::Aranha::AccommodationsProcessor
        common_constructor :url, :session, :index, super_args: -> { [url] }

        # @return [Boolean]
        def all_data_loaded?
          parser.data.fetch(:accommodations).all? { |e| e.fetch(:name).present? }
        end

        # @return [Addressable::URI]
        def next_page_url
          data.fetch(:next_page_href).if_present do |v|
            url + v
          end
        end

        require_sub __FILE__, require_mode: :kernel
      end
    end
  end
end
