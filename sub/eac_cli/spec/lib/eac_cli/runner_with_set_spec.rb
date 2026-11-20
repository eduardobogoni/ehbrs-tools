# frozen_string_literal: true

RSpec.describe EacCli::RunnerWithSet do
  let(:instance) { described_class.new.add_namespace(namespace) }
  let(:namespace) do
    Module.new.tap do |namespace|
      namespace.const_set(:LeafModule, Module.new)
      namespace.const_set(:NestedModule, Module.new)
      namespace.const_get(:NestedModule).const_set(:LeafModule, Module.new)
    end
  end

  describe '#item_to_module' do
    {
      leaf_module: 'LeafModule', 'nested_module/leaf_module': 'NestedModule::LeafModule'
    }.each do |key, module_name|
      context "when key is \"#{key}\"" do
        it do
          expect(instance.item_to_module(key)).to eq(namespace.const_get(module_name))
        end
      end
    end

    %i[missing_module nested_module/missing_module missing_module/leaf_module].each do |key|
      context "when key is \"#{key}\"" do
        it { expect { instance.item_to_module(key) }.to raise_error(/Not module found/) }
      end
    end
  end
end
