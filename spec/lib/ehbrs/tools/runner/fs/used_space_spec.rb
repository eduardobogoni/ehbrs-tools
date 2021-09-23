# frozen_string_literal: true

require 'eac_fs/cache'
require 'eac_ruby_utils/fs/temp'
require 'ehbrs/tools/runner'
require 'ehbrs/tools/runner/fs/used_space'
require 'ehbrs/observers/with_persistence'

RSpec.describe ::Ehbrs::Tools::Runner::Fs::UsedSpace do
  let(:target) { ::EacRubyUtils::Fs::Temp.directory }
  let(:user_dir) { ::EacRubyUtils::Fs::Temp.directory }
  let(:cached_user_dir) { ::EacFs::Cache.new(user_dir) }
  let(:observers_user_dir) { cached_user_dir.child('observers') }
  let(:observer_path) do
    observers_user_dir.child(target.to_s.parameterize).content_path.to_pathname
  end

  before do
    allow(::Ehbrs::UserDirs).to receive(:data).and_return(cached_user_dir)
  end

  after { [target, user_dir].each(&:remove!) }

  it { expect(observer_path).not_to exist }
  it { expect(cached_user_dir.path.to_pathname).to exist }

  %w[--check --verbose].bool_array_combs.each do |comb|
    it "run with options #{comb}" do
      expect { runner_run(*comb, target.to_path) }.not_to raise_error
    end
  end

  context 'when is firstly checked' do
    before { runner_run('--check', target.to_path) }

    it { expect(observer_path).to exist }
    it { expect(observer.records.count).to eq(1) }

    context 'when target does not change' do
      before { runner_run('--check', target.to_path) }

      it { expect(observer.records.count).to eq(1) }
    end

    context 'when target changes' do
      before do
        target.join('a_file').write('A' * 1024)
        runner_run('--check', target.to_path)
      end

      it { expect(observer.records.count).to eq(2) }
    end
  end

  def observer
    ::Ehbrs::Observers::WithPersistence.new(observer_path)
  end

  def runner_run(*args)
    ::Ehbrs::Tools::Runner.run(argv: %w[fs used-space] + args)
  end
end
