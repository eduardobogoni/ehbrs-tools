# frozen_string_literal: true

module Ehbrs
  module Videos
    module Series
      module Rename
        class File
          class Options
            common_constructor :options
            delegate :kernel, :confirm, :recursive, :extension, to: :options

            def episode_increment
              options.episode_increment.if_present(0, &:to_i)
            end
          end
        end
      end
    end
  end
end
