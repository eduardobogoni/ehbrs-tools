# frozen_string_literal: true

require 'eac_ruby_base0/application'

module Ehbrs
  module Tools
    class << self
      def application
        @application ||= ::EacRubyBase0::Application.new(::File.expand_path('../../..', __dir__))
      end
    end
  end
end
