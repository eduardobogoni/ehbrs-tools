# frozen_string_literal: true

require 'ehbrs_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Music
    class LyricsBook
      class Resource
        class << self
          def create_list(parent, files)
            r = files.sort.map { |path| new(parent, path) }.select(&:valid?)
            previous = parent.first_previous
            r.map do |e|
              e.previous = previous
              previous = e
            end
          end
        end

        enable_simple_cache
        include ::Comparable
        common_constructor :parent, :path
        attr_accessor :previous

        def filename
          path.relative_path_from(parent.path)
        end

        def <=>(other)
          path <=> other.path
        end

        def link_to_header
          "<a href=\"##{header_id}\" id=\"#{index_id}\">#{header_title}</a>"
        end

        def index_id
          "index_#{header_id}"
        end

        def header_id
          header_title.variableize
        end

        def header_index
          parent.header_index + 1
        end

        def output_main
          ::EhbrsRubyUtils::Music::LyricsBook::Resource.erb_template('main.html.erb', binding)
        end

        def output_index
          erb_template('index.html.erb')
        end

        def type
          self.class.name.demodulize.underscore
        end
      end
    end
  end
end
