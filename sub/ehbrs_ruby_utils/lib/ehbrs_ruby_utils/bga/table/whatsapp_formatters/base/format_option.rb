# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Base
          class FormatOption
            acts_as_instance_method
            common_constructor :table_formatter, :option

            # @return [String]
            def result
              ::EhbrsRubyUtils::Bga::WhatsappFormatter::Option.assert(option).to_s
            end
          end
        end
      end
    end
  end
end
