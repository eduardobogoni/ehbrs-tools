# frozen_string_literal: true

require 'ehbrs/videos/unsupported/fixes/supported_container'

module Ehbrs
  module Videos
    module Unsupported
      module Checks
        class InvalidExtension
          TYPE = :container

          common_constructor :extension

          def check(video)
            return nil unless ::File.extname(video.path) == extension

            "File has invalid extension: #{extension}"
          end

          def fix
            ::Ehbrs::Videos::Unsupported::Fixes::SupportedContainer.new
          end
        end
      end
    end
  end
end
