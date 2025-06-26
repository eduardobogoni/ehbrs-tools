# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Booking
        require_sub __FILE__

        runner_with :help, :subcommands do
          desc 'Utilidades para o site booking.com.'
          subcommands
        end
      end
    end
  end
end
