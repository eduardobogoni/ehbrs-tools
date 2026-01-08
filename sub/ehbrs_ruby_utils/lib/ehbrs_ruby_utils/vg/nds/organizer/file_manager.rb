# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Nds
      class Organizer
        class FileManager
          enable_simple_cache
          common_constructor :runner

          ROM_EXTNAMES = ['.nds'].freeze
          SAVE_EXTNAMES = ['.sav'].freeze

          def add_file(path)
            if ROM_EXTNAMES.include?(path.extname)
              add_to_set(:rom, path)
            elsif SAVE_EXTNAMES.include?(path.extname)
              add_to_set(:save, path)
            else
              ::EhbrsRubyUtils::Vg::Nds::Organizer::BaseFile::ADD_ERROR_UNRECOGNIZED
            end
          end

          def find_rom(id)
            roms.find { |s| s.id == id }
          end

          protected

          def add_to_set(type, path)
            set = send(type.to_s.pluralize)
            file = ::EhbrsRubyUtils::Vg::Nds::Organizer.const_get("#{type}_file".camelize)
                     .new(self, path)
            return ::BaseFile::ADD_ERROR_DUPLICATED if set.include?(file)

            set.add(file)
            nil
          end

          def roms
            @roms ||= ::Set.new
          end

          def saves
            @saves ||= ::Set.new
          end

          def to_change_files_uncached
            (roms.to_a + saves.to_a).select(&:change?).sort_by { |f| [f.id, f.target_path] }
          end
        end
      end
    end
  end
end
