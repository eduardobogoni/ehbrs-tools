# frozen_string_literal: true

require 'ehbrs/vg/wii/wit/path'

RSpec.describe ::Ehbrs::Vg::Wii::Wit::Path do
  describe '#parse' do
    context 'when type is present' do
      let(:source) { 'WbFs:path/to/file.wbfs' }
      let(:instance) { described_class.parse(source) }

      it { expect(instance.type).to eq('WBFS') }
      it { expect(instance.path.to_s).to eq('path/to/file.wbfs') }
    end

    context 'when type is blank' do
      let(:source) { 'path/to/file.wbfs' }
      let(:instance) { described_class.parse(source) }

      it { expect(instance.type).to eq('') }
      it { expect(instance.path.to_s).to eq('path/to/file.wbfs') }
    end
  end

  describe '#change?' do
    let(:with_type) { described_class.new('ISO', 'path/to/file.wbfs') }
    let(:without_type) { described_class.new(nil, 'path/to/file.wbfs') }

    it { expect(with_type.change?(without_type)).to eq(false) }
    it { expect(without_type.change?(with_type)).to eq(true) }

    context 'when'
  end
end
