# frozen_string_literal: true

require 'ehbrs_ruby_utils/bga/parsers/table/ended_players'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Table
      class Player
        common_constructor :table, :data

        ::EhbrsRubyUtils::Bga::Parsers::Table::EndedPlayers.fields.each do |field|
          define_method field.name do
            data.fetch(field.name)
          end
        end
      end
    end
  end
end
