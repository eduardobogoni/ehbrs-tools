# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Videos
    module Series
      module Rename
        class File
          class Renamer
            enable_speaker
            common_constructor :owner
            delegate :current_name, :dirname, :file, :new_name, to: :owner

            def perform
              return unless rename?

              version_number = 0
              loop do
                target_path = dirname.join(build_target_name(version_number))
                break perform_rename(target_path) unless target_path.exist?

                version_number += 1
              end
            end

            private

            def build_target_name(version_number)
              return new_name unless version_number.positive?

              extname = ::File.extname(new_name)
              "#{::File.basename(new_name, extname)}.v#{version_number}#{extname}"
            end

            def perform_rename(target_path)
              infov 'Renaming', file.to_path
              ::FileUtils.mv(file.to_path, target_path.to_path)
            end

            def rename?
              return false unless new_name

              current_name != new_name
            end
          end
        end
      end
    end
  end
end
