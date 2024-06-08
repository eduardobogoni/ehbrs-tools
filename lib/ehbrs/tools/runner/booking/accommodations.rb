# frozen_string_literal: true

require 'eac_ruby_base0/core_ext'
require 'ehbrs_ruby_utils/booking/processors/list'

module Ehbrs
  module Tools
    class Runner
      class Booking
        class Accommodations
          FIELDS = [
            [:link, 'Link'],
            [:price, 'Diárias'],
            [:tax, 'Taxas'],
            [:total, 'Total'],
            [:address, 'Localização'],
            [:distance, 'Dist. centro (Km)'],
            [:review_score, 'Nota'],
            [:review_count, 'Avaliações'],
            [:unit_title, 'Descrição']
          ].freeze

          runner_with :help, :output_list do
            desc 'Extrai as acomodações de uma página-lista do Booking.'
            pos_arg :url
          end

          def run
            run_output
            infov 'Actual count found', list_rows.count
            infov 'Declared count', processor.declared_count
            if list_rows.count == processor.declared_count
              success 'Ok!'
            else
              fatal_error 'Actual and declared counts are different'
            end
          end

          protected

          # @return [EhbrsRubyUtils::Booking::Processors::List]
          def processor_uncached
            ::EhbrsRubyUtils::Booking::Processors::List.new(url)
          end

          # @return [Array<Symbol>]
          def list_columns
            FIELDS.map(&:first)
          end

          # @return [Array<Object>]
          def list_rows
            processor.accommodations
          end

          # @return [Addressable::URI]
          def url
            parsed.url.to_uri
          end
        end
      end
    end
  end
end
