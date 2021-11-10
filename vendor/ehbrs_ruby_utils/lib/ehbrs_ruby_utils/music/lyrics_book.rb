# frozen_string_literal: true

require 'ehbrs_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Music
    class LyricsBook
      require_sub __FILE__

      DEFAULT_PROVIDER_NAME = 'lyrics.com'
      DEFAULT_TITLE = 'Letras de músicas'

      enable_listable
      lists.add_symbol :option, :provider_name, :title
      enable_simple_cache
      common_constructor :source_dir, :options, default: [{}] do
        self.source_dir = source_dir.to_pathname
        self.options = self.class.lists.option.hash_keys_validate!(options)
      end

      def first_previous
        nil
      end

      def header_index
        1
      end

      def output
        erb_template('main.html.erb')
      end

      def path
        source_dir
      end

      def title
        options[OPTION_TITLE].if_present(DEFAULT_TITLE)
      end

      private

      def albums_directories_uncached
        r = []
        t = ::EacFs::Traverser.new
        t.recursive = true
        t.check_directory = ->(directory) { r << directory }
        t.check_path(source_dir)
        r
      end

      def albums_uncached
        ::EhbrsRubyUtils::Music::LyricsBook::Album.create_list(self, albums_directories)
      end

      def provider_uncached
        ::UltimateLyrics::Provider.by_name(provider_name)
      end

      def provider_name
        options[OPTION_PROVIDER_NAME].if_present(DEFAULT_PROVIDER_NAME)
      end
    end
  end
end
