# frozen_string_literal: true

RSpec.shared_examples 'source_target_fixtures_raw' do |spec_file|
  include_examples 'source_target_fixtures', spec_file

  def target_content(data)
    data
  end

  def target_data(target_file)
    File.binread(target_file)
  end

  def target_file_extname
    '.txt'
  end
end
