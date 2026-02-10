# frozen_string_literal: true

require 'ostruct'

module EhbrsRubyUtils
  module WebUtils
    module Videos
      class File < ::SimpleDelegator
        def initialize(data)
          super(data.to_struct)
        end

        def exist?
          ::File.exist?(original_path)
        end

        def move(target_dir)
          ::EhbrsRubyUtils::WebUtils::Videos::File::Rename.new(
            self,
            target_dir.to_pathname.join(original_path.to_pathname.relative_path_from(root_path))
          ).perform
        end

        def path_changed?
          original_path != new_path
        end

        def remove
          return unless exist?

          ::File.unlink(original_path)
        end

        def rename
          ::EhbrsRubyUtils::WebUtils::Videos::File::Rename.new(self, new_path).perform
        end
      end
    end
  end
end
