# frozen_string_literal: true

require 'ehbrs/self/observers/with_persistence'

module Ehbrs
  module Self
    module Observers
      class UsedSpace < ::Ehbrs::Self::Observers::WithPersistence
        def path
          label
        end

        def calculate_value
          env = ::EacRubyUtils::Envs.local
          env.command('du', '-sb', path.to_s).pipe(
            env.command('cut', '-f', '-1')
          ).execute!.strip.to_i
        end
      end
    end
  end
end
