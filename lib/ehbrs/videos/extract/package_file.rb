# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Ehbrs
  module Videos
    module Extract
      class PackageFile
        DEFAULT_QUALITY = '__default__'

        enable_simple_cache
        common_constructor :package, :path do
          self.path = path.to_pathname
        end

        def copy_to_selected_dir
          ::FileUtils.cp(path.to_path, selected_dir.to_path)
        end

        def match_quality?(quality)
          path.basename_sub { |b| b.to_s.downcase }.basename
            .fnmatch?("*#{quality.downcase}*".gsub(/\A\*+/, '*').gsub(/\*+\z/, '*'))
        end

        def move_to_quality_dir
          ::FileUtils.mv(path.to_path, quality_dir.to_path)
        end

        private

        def quality_uncached
          package.qualities.find { |q| match_quality?(q) } || DEFAULT_QUALITY
        end

        def quality_dir
          r = package.target_dir / quality
          r.mkpath
          r
        end

        def selected_dir
          r = nil
          r = package.target_dir / 'source' if /\.torrent/ =~ path.to_path
          r = package.target_dir / 'subtitle' if /\.srt/ =~ path.to_path
          raise "Destination unknown: #{path}" unless r

          r.mkpath
          r
        end
      end
    end
  end
end
