# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Nds
      class Organizer
        class FileManager
          enable_simple_cache
          common_constructor :runner

          EXTNAMES = {
            '.nds' => ::EhbrsRubyUtils::Vg::Nds::Organizer::RomFile,
            '.pub' => ::EhbrsRubyUtils::Vg::Nds::Organizer::PubFile,
            '.sav' => ::EhbrsRubyUtils::Vg::Nds::Organizer::SaveFile
          }.freeze

          def add_file(path)
            if EXTNAMES.key?(path.extname)
              add_to_set(EXTNAMES.fetch(path.extname), path)
            else
              ::EhbrsRubyUtils::Vg::Nds::Organizer::BaseFile::ADD_ERROR_UNRECOGNIZED
            end
          end

          def find_rom(id)
            file_set(::EhbrsRubyUtils::Vg::Nds::Organizer::RomFile).find { |s| s.id == id }
          end

          protected

          def add_to_set(type, path)
            set = file_set(type)
            file = type.new(self, path)
            if set.include?(file)
              return ::EhbrsRubyUtils::Vg::Nds::Organizer::BaseFile::ADD_ERROR_DUPLICATED
            end

            set.add(file)
            nil
          end

          def file_set(type)
            file_sets[type] ||= ::Set.new
            file_sets.fetch(type)
          end

          def file_sets
            @sets ||= {}
            @sets
          end

          def to_change_files_uncached
            file_sets.values.flat_map(&:to_a).flat_map.select(&:change?)
              .sort_by { |f| [f.id, f.target_path] }
          end
        end
      end
    end
  end
end
