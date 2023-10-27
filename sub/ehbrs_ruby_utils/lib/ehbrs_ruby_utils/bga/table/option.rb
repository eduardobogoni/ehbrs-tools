# frozen_string_literal: true

require 'ehbrs_ruby_utils/bga/parsers/table/options'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Table
      class Option
        common_constructor :table, :data

        ::EhbrsRubyUtils::Bga::Parsers::Table::Options.fields.each do |field|
          define_method field.name do
            data.fetch(field.name)
          end
        end
      end
    end
  end
end
