# frozen_string_literal: true

require 'eac_docker/images/templatized'

module EhbrsRubyUtils
  module Finances
    module BbBrowser
      class DockerImage < ::EacDocker::Images::Templatized
        class << self
          def create
            new.tag(name.variableize)
          end
        end
      end
    end
  end
end
