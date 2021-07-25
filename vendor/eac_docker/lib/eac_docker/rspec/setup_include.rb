# frozen_string_literal: true

require 'eac_ruby_utils/rspec/conditional'
require 'eac_docker/executables'

module EacDocker
  module Rspec
    module SetupInclude
      class << self
        def setup(setup_obj)
          setup_conditional_docker_executable(setup_obj)
        end

        def setup_conditional_docker_executable(setup_obj)
          ::EacRubyUtils::Rspec::Conditional.default.add(:docker) do
            ::EacDocker::Executables.docker.validate
          end
          ::EacRubyUtils::Rspec::Conditional.default.configure(setup_obj.rspec_config)
        end
      end
    end
  end
end
