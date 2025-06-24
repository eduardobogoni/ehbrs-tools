# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos
    module Series
      module Rename
        class ResultsBuilder < LineResultGroup
          def initialize(files)
            super('', files)
          end

          def line_out
            'Groups: '.cyan + children.count.to_s
          end

          protected

          def child_key
            :dirname
          end

          def child_class
            ::EhbrsRubyUtils::Videos::Series::Rename::DirectoryGroup
          end
        end
      end
    end
  end
end
