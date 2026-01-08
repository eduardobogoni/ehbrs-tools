# frozen_string_literal: true

require 'active_support/json'

module EhbrsRubyUtils
  module WebUtils
    module Videos
      class FilesList
        enable_speaker
        enable_simple_cache

        common_constructor :type_class, :root_path, :options do
          self.root_path = root_path.to_pathname
          raise "\"#{root_path}\" is not a directory" unless root_path.directory?

          self.options = options.with_indifferent_access.freeze
        end

        def write_to(path = nil)
          path ||= ::EacRubyUtils::Fs::Temp.file.to_path
          ::File.write(path, data.to_json)
          path
        end

        def data
          {
            root_path: root_path.to_path,
            type: type_class,
            files: files_data
          }
        end

        def files_data
          case type_class
          when 'Videos::MovieFile' then movies_files_data
          when 'Videos::SeriesDirectory' then series_files_data
          else raise "Unknown type class: \"#{type_class}\""
          end
        end

        def movies_files_data
          r = []
          Dir["#{root_path}/**/*"].each do |path|
            r << file_data(path) if ::File.file?(path)
          end
          r
        end

        def series_files_data
          r = []
          Dir["#{root_path}/*"].each do |path|
            r << file_data(path) if ::File.directory?(path)
          end
          r
        end

        def file_data(path)
          r = { original_path: path }
          r[:ffprobe_data] = file_ffprobe_data(path) if ::File.file?(path)
          r
        end

        def file_ffprobe_data(path)
          return {} unless options.fetch(:ffprobe)

          infom "Probing \"#{path}\"..."
          ::JSON.parse(::EhbrsRubyUtils::Executables.ffprobe.command(
            '-hide_banner', '-print_format', 'json', '-show_format', '-show_streams', path
          ).execute!)
        end
      end
    end
  end
end
