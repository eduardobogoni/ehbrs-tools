# frozen_string_literal: true

require 'ehbrs_ruby_utils/videos/series/rename/line_result_group'
require 'ehbrs_ruby_utils/videos/series/rename/season_group'

module EhbrsRubyUtils
  module Videos
    module Series
      module Rename
        class DirectoryGroup < LineResultGroup
          def line_out
            name.to_s.colorize(:light_yellow)
          end

          protected

          def child_key
            :season
          end

          def child_class
            ::EhbrsRubyUtils::Videos::Series::Rename::SeasonGroup
          end
        end
      end
    end
  end
end
