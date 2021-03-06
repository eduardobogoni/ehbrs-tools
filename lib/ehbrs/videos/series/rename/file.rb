# frozen_string_literal: true

require 'eac_ruby_utils/fs/extname'
require 'ostruct'
require_relative 'line_result'
require_relative 'file/basename_parser'

module Ehbrs
  module Videos
    module Series
      module Rename
        class File < ::Ehbrs::Videos::Series::Rename::LineResult
          include ::Ehbrs::Videos::Series::Rename::File::BasenameParser

          attr_reader :file, :options

          def initialize(file, options)
            @file = file
            @options = options
            @options = ::OpenStruct.new(options) if options.is_a?(::Hash)
          end

          def rename
            target = ::File.expand_path(new_name, dirname)
            return if ::File.exist?(target)

            infov 'Renaming', @file
            FileUtils.mv(@file, target)
          end

          def season
            return '??' if parse.blank?

            parse.fetch(:s)
          end

          def episode
            return '??' if parse.blank?

            parse.fetch(:e)
          end

          def dirname
            d = @file
            while d != '/'
              d = ::File.dirname(d)
              return ::File.expand_path(d) + '/' unless ::File.basename(d).starts_with?('_')
            end
            raise "series_dirname not found for #{@file}"
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

          def current_name
            ::File.expand_path(@file).gsub(/\A#{::Regexp.quote(dirname)}/, '')
          end

          def rename?
            return false unless new_name

            current_name != new_name
          end

          def kernel
            options.kernel || kernel_from_directory_name ||
              raise("Kernel undefined (File: #{@file})")
          end

          def kernel_from_directory_name
            dir = ::File.basename(dirname).sub(/\([0-9]+\)/, '')
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
