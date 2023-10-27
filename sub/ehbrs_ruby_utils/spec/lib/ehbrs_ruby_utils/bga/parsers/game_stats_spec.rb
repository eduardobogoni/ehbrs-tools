# frozen_string_literal: true

require 'ehbrs_ruby_utils/bga/parsers/game_stats'

::RSpec.describe ::EhbrsRubyUtils::Bga::Parsers::GameStats do
  include_examples 'source_target_fixtures', __FILE__
end
