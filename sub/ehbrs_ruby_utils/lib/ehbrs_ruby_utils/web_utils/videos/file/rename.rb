# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module WebUtils
    module Videos
      class File < ::SimpleDelegator
        class Rename
          common_constructor :file, :target_path

          delegate :original_path, to: :file

          def can_rename?
            ::File.exist?(original_path) && !::File.exist?(target_path)
          end

          def perform
            return unless can_rename?

            ::FileUtils.mkdir_p(::File.dirname(target_path))
            ::FileUtils.mv(original_path, target_path)
          end
        end
      end
    end
  end
end
