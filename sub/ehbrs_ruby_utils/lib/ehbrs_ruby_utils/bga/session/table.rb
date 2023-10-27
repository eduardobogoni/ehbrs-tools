# frozen_string_literal: true

require 'ehbrs_ruby_utils/bga/parsers/table'
require 'ehbrs_ruby_utils/bga/table'
require 'ehbrs_ruby_utils/bga/urls'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      class Table
        include ::EhbrsRubyUtils::Bga::Urls
        enable_method_class
        enable_simple_cache
        common_constructor :session, :table_id

        def result
          ::EhbrsRubyUtils::Bga::Table.new(
            fetch_data
          )
        end

        # @return [Addressable::URI]
        def url
          table_url(table_id)
        end

        private

        def fetch_data
          session.navigate.to url
          session.wait_for_element(xpath: parser_class.const_get('PLAYERS_XPATH'))
          { id: table_id }.merge(parser_class.from_content(session.current_source).data)
        end

        # @return [Class]
        def parser_class
          ::EhbrsRubyUtils::Bga::Parsers::Table
        end
      end
    end
  end
end
