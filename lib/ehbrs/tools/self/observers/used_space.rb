# frozen_string_literal: true

module Ehbrs
  module Tools
    module Self
      module Observers
        class UsedSpace < ::Ehbrs::Tools::Self::Observers::WithPersistence
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
end
