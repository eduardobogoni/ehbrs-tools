# frozen_string_literal: true

module EacRubyBase0
  module Rspec
    module Setup
      def self.extended(obj)
        obj.disable_input_request
        obj.stub_eac_config_node
      end
    end
  end
end
