# frozen_string_literal: true

RSpec.describe(EacRubyUtils::Rspec::Setup::SetupManager) do
  describe '#setup_manager' do
    it do
      expect(setup_manager).to be_a(EacRubyUtils::Rspec::SetupManager)
    end
  end

  describe '#app_root_path' do
    it { expect(app_root_path).to be_a(Pathname) }
    it { expect(app_root_path).to be_directory }
  end
end
