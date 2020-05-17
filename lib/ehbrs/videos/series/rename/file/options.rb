# frozen_string_literal: true

module Ehbrs
  module Videos
    module Series
      module Rename
        class File
          class Options
            def initialize(docopt_runner_options)
              @options = docopt_runner_options
            end

            %w[kernel confirm recursive extension].each do |method|
              class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{method}
        @options.fetch('--#{method}')
      end
              RUBY_EVAL
            end

            def episode_increment
              r = @options.fetch('--episode-increment')
              r.present? ? r.to_i : 0
            end
          end
        end
      end
    end
  end
end
