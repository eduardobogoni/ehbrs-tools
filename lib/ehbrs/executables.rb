# frozen_string_literal: true

require 'eac_ruby_utils/envs'
require 'eac_ruby_utils/simple_cache'

module Ehbrs
  module Executables
    class << self
      include ::EacRubyUtils::SimpleCache

      def env
        ::EacRubyUtils::Envs.local
      end
    end
  end
end
