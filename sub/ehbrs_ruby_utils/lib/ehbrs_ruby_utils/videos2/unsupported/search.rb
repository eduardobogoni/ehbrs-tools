# frozen_string_literal: true

require 'eac_fs/traversable'

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      class Search
        include ::EacFs::Traversable

        enable_speaker
        enable_simple_cache

        VALID_EXTENSIONS = %w[.avi .mp4 .mkv .m4v].freeze

        def initialize(root, file_options)
          @root = root
          @file_options = file_options
          @files = 0
          @videos = 0
          @unsupported = 0
          run
        end

        def traverser_recursive # rubocop:disable Naming/PredicateMethod
          true
        end

        def traverser_sort # rubocop:disable Naming/PredicateMethod
          true
        end

        private

        def run
          start_banner
          traverser_check_path(@root)
          end_banner
        end

        def traverser_check_file(file)
          @files += 1
          check_video(file) if video_file?(file)
        end

        def check_video(file)
          @videos += 1
          v = ::EhbrsRubyUtils::Videos2::Unsupported::File.new(file, @file_options)
          return if v.all_passed?

          @unsupported += 1
          v.banner
          v.check_fix
        end

        def start_banner
          infom "Searching in: \"#{@root}\""
        end

        def end_banner
          infom "Unsupported/Videos/Files: #{@unsupported}/#{@videos}/#{@files}"
        end

        def video_file?(path)
          valid_extensions.include?(::File.extname(path))
        end

        def valid_extensions
          self.class::VALID_EXTENSIONS
        end
      end
    end
  end
end
