# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/fs/selected/build_file'

module EhbrsRubyUtils
  module Fs
    class Selected
      class Build
        DEFAULT_TARGET_BASENAME_PROC = proc { |path| path.basename.to_path }

        attr_reader :selected, :target_dir, :target_basename_proc

        def initialize(selected, target_dir, &target_basename_proc)
          @selected = selected
          @target_dir = target_dir.to_pathname
          @target_basename_proc = target_basename_proc.presence || DEFAULT_TARGET_BASENAME_PROC
        end

        def perform
          clear_target_dir
          link_selected_found
        end

        private

        def clear_target_dir
          target_dir.children.each do |c|
            c.unlink if c.symlink? && c.directory?
          end
        end

        def link_selected_found
          selected.found.each do |found|
            ::EhbrsRubyUtils::Fs::Selected::BuildFile.new(self, found).perform
          end
        end
      end
    end
  end
end
