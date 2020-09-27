# frozen_string_literal: true

require 'json'
require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/executables'
require 'ehbrs_ruby_utils/videos/container/info'

module EhbrsRubyUtils
  module Videos
    module Container
      class File
        enable_simple_cache
        common_constructor :path do
          self.path = path.to_pathname
        end

        private

        def info_uncached
          ::EhbrsRubyUtils::Videos::Container::Info.new(
            ::JSON.parse(
              ::EhbrsRubyUtils::Executables.ffprobe.command(
                '-hide_banner', '-print_format', 'json', '-show_format', '-show_streams', path
              ).execute!
            )
          )
        end
      end
    end
  end
end
