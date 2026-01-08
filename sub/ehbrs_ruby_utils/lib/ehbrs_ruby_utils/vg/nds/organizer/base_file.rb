# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Nds
      class Organizer
        class BaseFile
          acts_as_abstract :target_path
          enable_listable
          enable_simple_cache
          enable_speaker
          lists.add_symbol :add_error, :duplicated, :unrecognized
          common_constructor :file_manager, :source_path do
            self.source_path = source_path.to_pathname.expand_path
          end
          delegate :runner, to: :file_manager
          compare_by :id

          def change?
            source_path != target_path
          end

          def id
            source_path.basename_noext.to_path
          end

          def perform
            return unless change?

            ::FileUtils.mv(source_path, target_path.assert_parent)
          end

          def show
            puts "#{format_path(target_path, :green)} <= #{format_path(source_path, :yellow)}"
          end

          protected

          def format_path(path, color)
            path.relative_path_from(runner.runner.roms_root).to_path.colorize(color)
          end
        end
      end
    end
  end
end
