# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Airbnb
        class Accommodations < ::Ehbrs::Tools::Accommodations::Runner
          FIELDS = [
            [:link, 'Link'],
            [:price, 'Total'],
            [:type, 'Tipo'],
            [:address, 'Endereço'],
            [:review_score, 'Nota'],
            [:review_count, 'Avaliações']
          ].freeze
        end
      end
    end
  end
end
