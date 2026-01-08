# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Nds
      class Organizer
        class RomFile < ::EhbrsRubyUtils::Vg::Nds::Organizer::BaseFile
          protected

          def target_path_uncached
            source_path
          end
        end
      end
    end
  end
end
