# frozen_string_literal: true

require 'eac_docker/images/templatized'
require 'ehbrs_ruby_utils/patches/object/template'

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
