# frozen_string_literal: true

require 'ehbrs/videos/series/rename/directory_group'
require 'ehbrs/videos/series/rename/line_result_group'

module Ehbrs
  module Videos
    module Series
      module Rename
        class ResultsBuilder < LineResultGroup
          def initialize(files)
            super '', files
          end

          def line_out
            'Groups: '.cyan + children.count.to_s
          end

          protected

          def child_key
            :dirname
          end

          def child_class
            ::Ehbrs::Videos::Series::Rename::DirectoryGroup
          end
        end
      end
    end
  end
end
