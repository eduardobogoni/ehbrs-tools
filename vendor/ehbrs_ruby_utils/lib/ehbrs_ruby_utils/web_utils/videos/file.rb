# frozen_string_literal: true

require 'ostruct'

module EhbrsRubyUtils
  module WebUtils
    module Videos
      class File < ::SimpleDelegator
        def initialize(data)
          super(::OpenStruct.new(data))
        end

        def exist?
          ::File.exist?(original_path)
        end

        def path_changed?
          original_path != new_path
        end

        def can_rename?
          ::File.exist?(original_path) && !::File.exist?(new_path)
        end

        def remove
          return unless exist?

          ::File.unlink(original_path)
        end

        def rename
          return unless can_rename?

          ::FileUtils.mkdir_p(::File.dirname(new_path))
          ::FileUtils.mv(original_path, new_path)
        end
      end
    end
  end
end
