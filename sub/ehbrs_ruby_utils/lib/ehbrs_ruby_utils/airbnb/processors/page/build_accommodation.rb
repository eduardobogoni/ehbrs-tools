# frozen_string_literal: true

module EhbrsRubyUtils
  module Airbnb
    module Processors
      class Page
        class BuildAccommodation
          acts_as_instance_method
          common_constructor :list, :data

          def result
            %i[link].inject(data) do |a, e|
              a.merge(e => send("#{e}_value"))
            end
          end

          # @return [String]
          def link_value
            "=HYPERLINK(\"#{url_value}\";\"#{data.fetch(:name)}\")"
          end

          # @return [Addressable::URI]
          def url_value
            list.url + data.fetch(:href)
          end
        end
      end
    end
  end
end
