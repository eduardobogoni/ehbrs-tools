# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Nds
      class Organizer
        class PubFile < ::EhbrsRubyUtils::Vg::Nds::Organizer::BaseFile
          protected

          def target_path_uncached
            file_manager.find_rom(id).if_present(source_path) do |v|
              v.target_path.dirname.join(source_path.basename)
            end
          end
        end
      end
    end
  end
end
