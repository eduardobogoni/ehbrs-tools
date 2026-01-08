# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Base
          class FormatPlayer
            acts_as_abstract :fields
            acts_as_instance_method
            common_constructor :table_formatter, :player

            FIELD_SEPARATOR = ' - '

            delegate :name, to: :player

            def result
              fields.map { |v| send(v) }.join(FIELD_SEPARATOR)
            end
          end
        end
      end
    end
  end
end
