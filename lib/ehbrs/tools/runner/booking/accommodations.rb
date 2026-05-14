# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Booking
        class Accommodations < ::Ehbrs::Tools::Accommodations::Runner
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
        end
      end
    end
  end
end
