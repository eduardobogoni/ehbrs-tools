# frozen_string_literal: true

RSpec.describe UltimateLyrics::Parser do
  include_examples 'source_target_fixtures', __FILE__

  def source_data(source_file)
    parser = described_class.new(
      provider_by_basename(File.basename(source_file)),
      File.read(source_file)
    )
    { url: parser.url?, result: parser.result }
  end

  def provider_by_basename(basename)
    UltimateLyrics::Provider.by_identifier(basename.split('__').first)
  end
end
