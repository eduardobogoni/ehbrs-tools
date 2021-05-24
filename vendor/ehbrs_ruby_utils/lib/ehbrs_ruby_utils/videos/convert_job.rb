# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/executables'
require 'fileutils'

module EhbrsRubyUtils
  module Videos
    class ConvertJob
      FORMATS_TO_EXTENSIONS = {
        'matroska' => '.mkv'
      }.freeze

      enable_speaker
      enable_simple_cache
      common_constructor :input, :ffmpeg_convert_args do
        self.input = input.to_pathname.expand_path
        raise "Input file \"#{input}\" does not exist or is not a file" unless input.file?
      end

      def run
        if converted.exist?
          warn("Converted file already exist: \"#{converted}\"")
        else
          convert
          swap
        end
      end

      def target
        input.dirname.join("#{input.basename('.*')}#{target_extension}")
      end

      private

      def command_args_uncached
        r = ['-i', input] + ffmpeg_convert_args
        r += ['-f', format_by_input] if format_by_args.blank?
        r + [converting]
      end

      def convert
        infov 'Input', input
        infov 'Target', target
        infov 'Convert args', command_args.shelljoin
        ::Ehbrs::Executables.ffmpeg.command.append(command_args).system!
      end

      def format_by_args_uncached
        ffmpeg_convert_args.rindex('-f').if_present do |option_index|
          ffmpeg_convert_args[option_index + 1]
        end
      end

      def format_by_input
        FORMATS_TO_EXTENSIONS.invert[target_extension_by_input].if_present { |v| return v }

        raise 'Unknonwn target format'
      end

      def format_to_extension(format)
        FORMATS_TO_EXTENSIONS[format].if_present(".#{format}")
      end

      def swap
        ::FileUtils.mv(input, converted)
        ::FileUtils.mv(converting, target)
      end

      def converting
        target.basename_sub { |b| "#{b}.converting" }
      end

      def converted
        input.basename_sub { |b| "#{b}.converted" }
      end

      def target_extension
        target_extension_by_args || target_extension_by_input
      end

      def target_extension_by_args
        format_by_args.if_present { |v| format_to_extension(v) }
      end

      def target_extension_by_input
        ::File.extname(input)
      end
    end
  end
end
