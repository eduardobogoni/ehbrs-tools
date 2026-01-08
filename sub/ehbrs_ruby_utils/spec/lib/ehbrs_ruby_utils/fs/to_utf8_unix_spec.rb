# frozen_string_literal: true

RSpec.describe EhbrsRubyUtils::Fs::ToUtf8Unix do
  include_examples 'source_target_fixtures_raw', __FILE__

  def source_data(source_file)
    described_class.convert_to_string(source_file)
  end
end
