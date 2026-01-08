# frozen_string_literal: true

RSpec.describe EhbrsRubyUtils::Vg::Wii::Wit::Parsers::Dump do
  include_examples 'source_target_fixtures', __FILE__

  def source_data(source_file)
    described_class.new(File.read(source_file)).properties
  end
end
