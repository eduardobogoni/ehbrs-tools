# frozen_string_literal: true

require 'eac_ruby_base0/application'

module Ehbrs
  module Tools
    module Application
      common_concern

      class_methods do
        def application
          @application ||= ::EacRubyBase0::Application.new(::File.expand_path('../../..', __dir__))
        end
      end
    end
  end
end
