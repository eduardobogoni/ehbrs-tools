# frozen_string_literal: true

require 'aranha/parsers/html/item_list'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class GameInProgress < ::Aranha::Parsers::Html::ItemList
        ITEMS_XPATH = '//*[@id = "gametables_inprogress_all"]' \
                      '//*[starts-with(@id, "gametableblock_")]'
        STATUS_CLASS_PATTERN = /\Agametable_status_(.+)\z/.freeze
        STATUS_CLASS_PARSER = STATUS_CLASS_PATTERN.to_parser { |m| m[1] }

        field :id, :integer, './@id'
        field :status, :string, './@class'

        def item_data(idd)
          %i[status].each do |key|
            idd[key] = send("process_#{key}", idd.fetch(key))
          end
          idd
        end

        def items_xpath
          ITEMS_XPATH
        end

        private

        def process_status(status)
          status.split.lazy.map { |s| STATUS_CLASS_PARSER.parse(s.strip) }.find(&:present?) ||
            raise("No status class found in \"#{status}\"")
        end
      end
    end
  end
end
