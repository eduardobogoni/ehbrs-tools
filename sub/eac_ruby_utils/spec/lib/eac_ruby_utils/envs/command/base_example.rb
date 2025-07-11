# frozen_string_literal: true

RSpec.shared_examples 'with_command_env' do
  let(:echo) { env.executable('echo', '--version') }
  let(:cat) { env.executable('cat', '--version') }
  let(:not_existing_file) { Pathname.new('a_file_that_not_exists') }
  let(:ok_command) { echo.command('-n', ok_command_output) }
  let(:ok_command_output) { 'THE OUTPUT' }
  let(:error_command) { cat.command(not_existing_file) }

  it { expect(echo).to exist }
  it { expect(cat).to exist }
  it { expect(not_existing_file).not_to exist }

  describe '#execute' do
    it do
      assert_execute_result(ok_command.execute, true, ok_command_output)
    end

    it do
      assert_execute_result(error_command.execute, false, '')
    end
  end

  describe '#execute!' do
    it { expect(ok_command.execute!).to eq(ok_command_output) }

    it do
      expect { error_command.execute! }.to(
        raise_error(EacRubyUtils::Envs::ExecutionError)
      )
    end
  end

  describe '#system' do
    it { expect(ok_command.system).to be(true) }
    it { expect(error_command.system).to be(false) }
  end

  describe '#system!' do
    it { expect { ok_command.system! }.not_to raise_error }

    it do
      expect { error_command.system! }.to(
        raise_error(EacRubyUtils::Envs::ExecutionError)
      )
    end
  end

  describe '#and' do
    it do
      assert_execute_result(ok_command.and(error_command).execute, false, ok_command_output)
    end

    it do
      assert_execute_result(error_command.and(ok_command).execute, false, '')
    end
  end

  describe '#before' do
    it do
      assert_execute_result(ok_command.before(error_command).execute, false, ok_command_output)
    end

    it do
      assert_execute_result(error_command.before(ok_command).execute, false, '')
    end
  end

  describe '#or' do
    it do
      assert_execute_result(ok_command.or(error_command).execute, true, ok_command_output)
    end

    it do
      assert_execute_result(error_command.or(ok_command).execute, true, ok_command_output)
    end
  end

  describe '#pipe' do
    it do
      assert_execute_result(ok_command.pipe(error_command).execute, false, '')
    end

    it do
      assert_execute_result(error_command.pipe(ok_command).execute, false, ok_command_output)
    end
  end

  def assert_execute_result(actual, expected_successful, expected_stdout)
    expect(successful: actual.fetch(:exit_code).zero?, stdout: actual.fetch(:stdout)).to(
      eq(successful: expected_successful, stdout: expected_stdout)
    )
  end
end
