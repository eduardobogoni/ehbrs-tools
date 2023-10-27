# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/bga/table/whatsapp_formatters/base/format_player'

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Ending < ::EhbrsRubyUtils::Bga::Table::WhatsappFormatters::Base
          class FormatPlayer < ::EhbrsRubyUtils::Bga::Table::WhatsappFormatters::Base::FormatPlayer
            acts_as_instance_method

            FIELDS = %w[table_rank name score].freeze

            def fields
              FIELDS
            end

            def table_rank
              "*#{player.rank}º*"
            end

            def score
              "⭐ #{player.score}"
            end
          end
        end
      end
    end
  end
end
