# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Booking
    module Processors
      class List
        class BuildAccommodation
          acts_as_instance_method
          common_constructor :list, :data

          TOTAL_VALUE = '=index($A:$ZZZ;row();column()-2)+index($A:$ZZZ;row();column()-1)'

          def result
            %i[link total].inject(data) do |a, e|
              a.merge(e => send("#{e}_value"))
            end
          end

          # @return [String]
          def link_value
            "=HYPERLINK(\"#{data.fetch(:href)}\";\"#{data.fetch(:name)}\")"
          end

          # @return [String]
          def total_value
            TOTAL_VALUE
          end
        end
      end
    end
  end
end
