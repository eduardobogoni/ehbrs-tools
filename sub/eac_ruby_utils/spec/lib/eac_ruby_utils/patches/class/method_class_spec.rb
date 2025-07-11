# frozen_string_literal: true

RSpec.describe Class, '#method_class' do
  let(:stub_method_class) do
    described_class.new do
      def self.name
        'StubMethodClass'
      end

      enable_method_class
    end
  end

  describe '#enable_simple_cache' do
    it { expect(stub_method_class.included_modules).to include(EacRubyUtils::MethodClass) }
  end
end
