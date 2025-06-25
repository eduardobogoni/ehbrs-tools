# frozen_string_literal: true

require 'eac_fs/file_info'

RSpec.describe EacFs::FileInfo do
  let(:instance) { described_class.new(__FILE__) }

  {
    charset: 'us-ascii',
    description: 'Ruby script, ASCII text',
    mime_type: 'text/x-ruby',
    subtype: 'x-ruby',
    type: 'text',
    open?: false
  }.each do |attribute, expected_value|
    describe "##{attribute}" do
      it do
        expect(instance.send(attribute)).to eq(expected_value)
      end
    end
  end
end
