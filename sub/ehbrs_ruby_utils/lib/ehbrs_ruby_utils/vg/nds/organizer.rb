# frozen_string_literal: true

require 'find'

module EhbrsRubyUtils
  module Vg
    module Nds
      class Organizer
        enable_simple_cache
        common_constructor :runner
        attr_reader :errors

        delegate :confirm?, :roms_root, :show?, to: :runner

        def add_files
          self.errors = {}
          reset_cache(:file_manager)
          ::Find.find(roms_root) do |path|
            pathname = path.to_pathname
            next unless pathname.file?

            file_manager.add_file(pathname).if_present do |error|
              errors[pathname] = error
            end
          end
        end

        def clean_empty_directories
          runner.infom 'Cleaning empty directories?'
          return unless confirm?

          roms_root.to_pathname.children.each do |child|
            ::EacFs::Utils.remove_empty_directories(child)
          end
        end

        def perform
          file_manager.to_change_files.each do |file|
            file.show if show?
            file.perform if confirm?
          end
        end

        def perform_all
          add_files
          show_changes if show?
          perform
          clean_empty_directories
        end

        def show_changes
          file_manager.to_change_files.each(&:show)
          runner.infov 'To change files', file_manager.to_change_files.count
        end

        protected

        attr_writer :errors

        # @return [FileManager]
        def file_manager_uncached
          ::EhbrsRubyUtils::Vg::Nds::Organizer::FileManager.new(self)
        end
      end
    end
  end
end
