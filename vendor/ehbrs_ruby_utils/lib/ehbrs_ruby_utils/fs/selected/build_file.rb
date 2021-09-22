# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Fs
    class Selected
      class BuildFile
        common_constructor :build, :path do
          self.path = path.to_pathname
        end

        def perform
          target_path.make_symlink(path)
        end

        def target_path
          build.target_dir.join(target_basename)
        end

        def target_basename
          build.target_basename_proc.call(path.basename.to_path)
        end
      end
    end
  end
end
