# frozen_string_literal: true

require 'avm/instances/base'
require 'eac_ruby_utils/core_ext'

module Ehbrs
  module Tools
    INSTANCE_ID = 'ehbrs-tools_0'

    class << self
      def instance
        @instance ||= ::Avm::Instances::Base.by_id(INSTANCE_ID)
      end
    end
  end
end
