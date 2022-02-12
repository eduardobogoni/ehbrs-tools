# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Videos
    module Series
      module Rename
        class File
          class Renamer
            common_constructor :owner
            delegate :dirname, :file, :new_name, to: :owner

            def perform
              target = dirname.join(new_game)
              return if target.exist?

              infov 'Renaming', file.to_path
              ::FileUtils.mv(file.to_path, target.to_path)
            end
          end
        end
      end
    end
  end
end
