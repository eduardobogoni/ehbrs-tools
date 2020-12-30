# frozen_string_literal: true

require 'eac_ruby_base0/runner'
require 'ehbrs/tools/application'

module Ehbrs
  class Runner
    require_sub __FILE__
    include ::EacRubyBase0::Runner

    runner_definition do
      desc 'Tools for EHB/RS.'
    end

    def application
      ::Ehbrs::Tools.application
    end
  end
end
