# frozen_string_literal: true

require 'eac_cli/runner'
require 'eac_ruby_utils/fs/traversable'

module EacRubyBase0
  module RunnerWith
    module Confirmable
      extend ::ActiveSupport::Concern

      included do
        include ::EacCli::Runner
        runner_definition do
          bool_opt '-c', '--confirm', 'Confirm changes.'
        end
      end

      delegate :confirm?, to: :parsed
    end
  end
end
