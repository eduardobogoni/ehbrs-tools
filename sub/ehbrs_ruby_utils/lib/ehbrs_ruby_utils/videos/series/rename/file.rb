# frozen_string_literal: true

require 'eac_ruby_utils/fs/extname'
require 'ehbrs_ruby_utils/videos/series/rename/line_result'
require 'ostruct'

module EhbrsRubyUtils
  module Videos
    module Series
      module Rename
        class File < ::EhbrsRubyUtils::Videos::Series::Rename::LineResult
          require_sub __FILE__, include_modules: true

          common_constructor :file, :options do
            self.file = file.to_pathname.expand_path
            self.options = options.to_struct if options.is_a?(::Hash)
          end

          # @return [String]
          def current_name
            file.basename.to_path
          end

          def rename
            EhbrsRubyUtils::Videos::Series::Rename::File::Renamer.new(self).perform
          end

          def season
            return '??' if parse.blank?

            parse.fetch(:s)
          end

          def episode
            return '??' if parse.blank?

            parse.fetch(:e)
          end

          # @return [Pathname]
          def dirname
            d = file
            until d.root?
              d = d.dirname
              return d unless d.basename.to_path.starts_with?('_')
            end
            raise "series_dirname not found for #{file.to_path}"
          end

          def line_out
            "#{episode.green}: " + if new_name == current_name
                                     current_name.light_black
                                   else
                                     "#{new_name} <= #{current_name}"
                                   end
          end

          def new_name
            return "#{kernel}-s#{parse[:s]}e#{new_name_episodes}#{extension}" if parse.present?

            current_name
          end

          private

          def kernel
            options.kernel || kernel_from_directory_name ||
              raise("Kernel undefined (File: #{file.to_path})")
          end

          def kernel_from_directory_name
            dir = dirname.basename.to_path.sub(/\([0-9]+\)/, '')
            dir.split(/\W+/).select { |w| /\A[a-z0-9]/.match(w) }.map { |p| p[0].downcase }.join('')
          end

          def extension
            return options.extension if options.extension

            extension_by_directory || ::EacRubyUtils::Fs.extname2(current_name)
          end

          def extension_by_directory
            r = ::File.dirname(current_name)
            return nil if r == '.'

            r.gsub(/\A_/, '.')
          end

          def source_episodes
            parse[:e].split('-').map(&:to_i)
          end

          def new_name_episodes
            source_episodes.map do |i|
              (i + options.episode_increment).to_s.rjust(2, '0')
            end.join('-')
          end
        end
      end
    end
  end
end
