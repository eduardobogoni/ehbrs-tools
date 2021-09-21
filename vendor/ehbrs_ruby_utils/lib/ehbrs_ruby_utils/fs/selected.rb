# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Fs
    class Selected
      require_sub __FILE__
      DEFAULT_FILENAME = '.selected'

      enable_listable
      enable_simple_cache
      lists.add_symbol :option, :filename, :target_name_builder
      common_constructor :root_path, :options, default: [{}] do
        self.root_path = root_path.to_pathname
        self.options = self.class.lists.option.hash_keys_validate!(options)
      end

      def build(target_dir)
        ::EhbrsRubyUtils::Fs::Selected::Build.new(self, target_dir)
      end

      def filename
        options[OPTION_FILENAME].if_present(DEFAULT_FILENAME)
      end

      private

      # @return [Pathname]
      def found_uncached
        root_path.glob("**/#{filename}").map(&:parent).sort
      end
    end
  end
end
