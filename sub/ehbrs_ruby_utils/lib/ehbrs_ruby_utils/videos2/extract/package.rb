# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/fs/compressed_package'
require 'ehbrs_ruby_utils/videos2/extract/package_file'

module EhbrsRubyUtils
  module Videos2
    module Extract
      class Package
        enable_simple_cache

        common_constructor :path, :target_dir, :qualities do
          self.path = path.to_pathname
          self.target_dir = target_dir.to_pathname
        end

        delegate :to_s, to: :path

        def run(delete)
          selected_files.each(&:copy_to_selected_dir)
          files.each(&:move_to_quality_dir)
          extract_dir.rmdir
          path.unlink if delete
        end

        private

        def files_uncached
          ::Pathname.glob("#{extract_dir}/**/*").map do |file|
            ::EhbrsRubyUtils::Videos2::Extract::PackageFile.new(self, file)
          end
        end

        def extract_dir_uncached
          r = target_dir / path.basename
          raise "Extract directory \"#{r}\" is a file" if r.file?

          r.rmtree if r.directory?
          ::EhbrsRubyUtils::Fs::CompressedPackage.new(path).extract_to(r)
          r
        end

        def files_qualities_uncached
          qualities_with_default.select { |q| grouped_files.keys.include?(q) }
        end

        def grouped_files_uncached
          r = {}
          files.each do |file|
            r[file.quality] ||= []
            r[file.quality] << file
          end
          r
        end

        def qualities_with_default
          qualities + [::EhbrsRubyUtils::Videos2::Extract::PackageFile::DEFAULT_QUALITY]
        end

        def selected_dir_uncached
          target_dir / 'selected'
        end

        def selected_files
          files.select { |f| f.quality == selected_quality }
        end

        def selected_quality_uncached
          files_qualities.first
        end
      end
    end
  end
end
