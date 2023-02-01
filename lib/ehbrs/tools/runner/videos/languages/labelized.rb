# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Languages
          class Labelized < ::SimpleDelegator
            attr_reader :runner

            def initialize(runner, object)
              @runner = runner
              super(object)
            end

            def to_label
              return to_s unless runner.keep_languages?

              to_s.colorize(runner.keep_languages.include?(language) ? :green : :red)
            end
          end
        end
      end
    end
  end
end
