# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Base
          class FormatOption
            acts_as_instance_method
            common_constructor :table_formatter, :option

            def result
              "*#{option.label}:* #{option.value}"
            end
          end
        end
      end
    end
  end
end
