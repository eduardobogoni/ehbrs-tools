# frozen_string_literal: true

require 'ehbrs/videos/convert_job'
require 'ehbrs/videos/file'
require 'ehbrs/videos/unsupported/fix_profile'

module Ehbrs
  module Videos
    module Unsupported
      class File < ::Ehbrs::Videos::File
        module Fix
          def check_fix
            return unless options.fetch(:fix)

            if fix_blocks.any?
              infom '  * Cannot fix:'
              fix_blocks.each do |fb|
                infom "    * #{fb.check.check_name}"
              end
            else
              infom '  * Fixing...'
              infom "  * Fixed in: \"#{fix}\""
            end
          end

          private

          def all_fix_blocks_uncached
            fix_blocks + tracks.flat_map(&:fix_blocks)
          end

          def fix_profile_uncached
            ::Ehbrs::Videos::Unsupported::FixProfile.new(self)
          end

          def fix
            job = ::Ehbrs::Videos::ConvertJob.new(path, fix_profile)
            job.run
            job.target
          end
        end
      end
    end
  end
end
