# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRubyUtils
  module Templates
    module VariableProviders
      require_sub __FILE__

      PROVIDERS = %w[entries_reader hash generic].map do |name|
        "eac_ruby_utils/templates/variable_providers/#{name}".camelize.constantize
      end

      class << self
        def build(variables_source)
          PROVIDERS.each do |provider|
            return provider.new(variables_source) if provider.accept?(variables_source)
          end

          raise "Variables provider not found for #{variables_source}"
        end
      end
    end
  end
end
