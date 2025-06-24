# frozen_string_literal: true

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
