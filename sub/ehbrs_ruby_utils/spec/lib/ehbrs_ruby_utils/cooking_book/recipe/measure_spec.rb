# frozen_string_literal: true

RSpec.describe EhbrsRubyUtils::CookingBook::Recipe::Measure do
  describe '#build'
  {
    '1.5 cup' => [1.5, nil, 'cup'],
    '~' => [nil, nil, nil],
    '2/ 3 u' => [2, 3, 'u'],
    '4.5/7.8' => [4.5, 7.8, nil]
  }.each do |source, expected|
    context "when source is \"#{source}\"" do
      let(:instance) { described_class.build(source) }

      it { expect(instance.numerator).to eq(expected[0]) }
      it { expect(instance.denominator).to eq(expected[1]) }
      it { expect(instance.unit).to eq(expected[2]) }
    end
  end
end
