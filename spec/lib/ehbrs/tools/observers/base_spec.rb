# frozen_string_literal: true

RSpec.describe Ehbrs::Tools::Observers::Base do
  let(:instance) { described_class.new }
  let(:first_value) { 'a value' }
  let(:same_value) { first_value.dup }
  let(:different_value) { 'another value' }
  let(:first_time) { Time.required_zone.local(2020, 5, 1, 12, 45, 0) }
  let(:second_time) { Time.required_zone.local(2020, 5, 1, 12, 45, 0) }

  it { expect(instance.records.count).to be_zero }
  it { expect(instance.last_change_time).to be_blank }
  it { expect(instance.last_check_time).to be_blank }

  it { expect(instance).to be_changing_value(nil) }
  it { expect(instance).to be_changing_value(first_value) }
  it { expect(instance).to be_changing_value(same_value) }
  it { expect(instance).to be_changing_value(different_value) }

  context 'when firstly checked' do
    before { instance.check(first_value, first_time) }

    it { expect(instance.records.count).to eq(1) }
    it { expect(instance.last_value).to eq(first_value) }
    it { expect(instance).not_to be_changing_value(same_value) }
    it { expect(instance).to be_changing_value(different_value) }
    it { expect(instance.last_change_time).to eq(first_time) }
    it { expect(instance.last_check_time).to eq(first_time) }

    context 'when same first_value is checked' do
      before { instance.check(same_value, second_time) }

      it { expect(instance.records.count).to eq(1) }
      it { expect(instance.last_value).to eq(same_value) }
      it { expect(instance.last_change_time).to eq(first_time) }
      it { expect(instance.last_check_time).to eq(second_time) }
    end

    context 'when different first_value is checked' do
      before { instance.check(different_value, second_time) }

      it { expect(instance.records.count).to eq(2) }
      it { expect(instance.last_value).to eq(different_value) }
      it { expect(instance.last_change_time).to eq(second_time) }
      it { expect(instance.last_check_time).to eq(second_time) }
    end

    context 'when checked first_value is blank' do
      context 'when blank_value == :add' do
        let(:instance) { described_class.new(blank_value: :add) }

        before { instance.check(nil, second_time) }

        it { expect(instance.records.count).to eq(2) }
        it { expect(instance.last_value).to be_nil }
        it { expect(instance.last_change_time).to eq(second_time) }
        it { expect(instance.last_check_time).to eq(second_time) }
      end

      context 'when blank_value == :ignore' do
        let(:instance) { described_class.new(blank_value: :ignore) }

        before { instance.check(nil, second_time) }

        it { expect(instance.records.count).to eq(1) }
        it { expect(instance.last_value).to eq(first_value) }
        it { expect(instance.last_change_time).to eq(first_time) }
        it { expect(instance.last_check_time).to eq(second_time) }
      end

      context 'when blank_value == :raise' do
        let(:instance) { described_class.new(blank_value: :raise) }

        before do
          @exception = nil
          begin
            instance.check(nil, second_time)
          rescue StandardError => e
            @exception = e
          end
        end

        it { expect(@exception).to be_a(ArgumentError) } # rubocop:disable RSpec/InstanceVariable
        it { expect(instance.records.count).to eq(1) }
        it { expect(instance.last_value).to eq(first_value) }
        it { expect(instance.last_change_time).to eq(first_time) }
        it { expect(instance.last_check_time).to eq(second_time) }
      end
    end
  end
end
