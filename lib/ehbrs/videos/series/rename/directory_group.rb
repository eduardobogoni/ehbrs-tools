# frozen_string_literal: true

require 'ehbrs/videos/series/rename/line_result_group'
require 'ehbrs/videos/series/rename/season_group'

module Ehbrs
  module Videos
    module Series
      module Rename
        class DirectoryGroup < LineResultGroup
          def line_out
            name.light_yellow
          end

          protected

          def child_key
            :season
          end

          def child_class
            ::Ehbrs::Videos::Series::Rename::SeasonGroup
          end
        end
      end
    end
  end
end
