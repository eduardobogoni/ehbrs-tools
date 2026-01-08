# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Beginning < ::EhbrsRubyUtils::Bga::Table::WhatsappFormatters::Base
          class FormatPlayer < ::EhbrsRubyUtils::Bga::Table::WhatsappFormatters::Base::FormatPlayer
            acts_as_instance_method

            FIELDS = %w[name].freeze

            def fields
              FIELDS
            end
          end
        end
      end
    end
  end
end
