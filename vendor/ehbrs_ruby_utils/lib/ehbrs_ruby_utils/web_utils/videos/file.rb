# frozen_string_literal: true

require 'ostruct'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module WebUtils
    module Videos
      class File < ::SimpleDelegator
        require_sub __FILE__

        def initialize(data)
          super(::OpenStruct.new(data))
        end

        def exist?
          ::File.exist?(original_path)
        end

        def path_changed?
          original_path != new_path
        end

        def remove
          return unless exist?

          ::File.unlink(original_path)
        end

        def rename
          ::EhbrsRubyUtils::WebUtils::Videos::File::Rename.new(self, new_path).perform
        end
      end
    end
  end
end
