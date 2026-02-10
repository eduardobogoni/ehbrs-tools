# frozen_string_literal: true

module EhbrsRubyUtils
  module Fs
    class Selected
      DEFAULT_FILENAME = '.selected'

      enable_listable
      enable_simple_cache
      lists.add_symbol :option, :filename, :target_name_builder
      common_constructor :root_path, :options, default: [{}] do
        self.root_path = root_path.to_pathname
        self.options = self.class.lists.option.hash_keys_validate!(options)
      end

      def build(target_dir, &directory_target_basename)
        ::EhbrsRubyUtils::Fs::Selected::Build.new(self, target_dir, &directory_target_basename)
      end

      def filename
        options[OPTION_FILENAME].if_present(DEFAULT_FILENAME)
      end

      private

      # @return [Pathname]
      def found_uncached
        r = []
        ft = ::EacFs::Traverser.new(
          recursive: true,
          hidden_directories: true,
          check_file: lambda do |file|
            r << file.parent if file.basename.to_path == filename.to_s
          end
        )
        ft.check_path(root_path)
        r.sort
      end
    end
  end
end
