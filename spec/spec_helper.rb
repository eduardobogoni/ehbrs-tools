# frozen_string_literal: true

require 'ehbrs/tools'
EacRubyUtils::Rspec.default_setup_create(File.expand_path('..', __dir__))
EacRubyUtils.require_sub __FILE__
