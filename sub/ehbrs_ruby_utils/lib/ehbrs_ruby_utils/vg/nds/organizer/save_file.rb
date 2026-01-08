# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Nds
      class Organizer
        class SaveFile < ::EhbrsRubyUtils::Vg::Nds::Organizer::BaseFile
          SAVES_DIRECTORY_BASENAME = 'saves'.to_pathname

          protected

          def target_path_uncached
            rom_file.if_present(source_path) do |v|
              v.target_path.dirname.join(SAVES_DIRECTORY_BASENAME).join(source_path.basename)
            end
          end

          def rom_file_uncached
            file_manager.find_rom(id)
          end
        end
      end
    end
  end
end
