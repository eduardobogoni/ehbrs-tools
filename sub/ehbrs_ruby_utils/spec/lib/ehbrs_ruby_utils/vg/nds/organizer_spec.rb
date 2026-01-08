# frozen_string_literal: true

RSpec.describe EhbrsRubyUtils::Vg::Nds::Organizer do
  let(:runner) { runner_class.new }
  let(:runner_class) do
    Class.new do
      attr_accessor :roms_root

      def confirm?(*_args)
        true
      end

      def infom(*args); end

      def show?(*_args)
        false
      end
    end
  end

  include_examples 'source_target_fixtures', __FILE__

  def fs_comparator
    EacFs::Comparator.new
  end

  def source_data(source_dir)
    runner.roms_root = temp_dir_copy(source_dir)
    described_class.new(runner).perform_all
    fs_comparator.build(runner.roms_root)
  end

  def target_data(target_dir)
    fs_comparator.build(target_dir.to_pathname)
  end
end
