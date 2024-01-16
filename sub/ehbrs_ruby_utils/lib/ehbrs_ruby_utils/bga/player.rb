# frozen_string_literal: true

require 'ehbrs_ruby_utils/bga/parsers/table/active_players'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Player
      common_constructor :data

      ::EhbrsRubyUtils::Bga::Parsers::Table::ActivePlayers.fields.map(&:name).each do |field|
        define_method field do
          data.fetch(field)
        end
      end
    end
  end
end
