# frozen_string_literal: true

module Ehbrs
  module Tools
    module Executables
      class << self
        include ::EacRubyUtils::SimpleCache

        def env
          ::EacRubyUtils::Envs.local
        end
      end
    end
  end
end
