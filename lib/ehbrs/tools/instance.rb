# frozen_string_literal: true

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
