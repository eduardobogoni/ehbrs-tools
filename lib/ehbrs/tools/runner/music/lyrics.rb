# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Music
        class Lyrics
          DEFAULT_PROVIDER = 'lyrics.com'

          runner_with :help, :output do
            arg_opt '-p', '--provider', 'Nome do provedor.', default: DEFAULT_PROVIDER
            pos_arg :file
          end

          def run
            start_banner
            show_results
          end

          def show_results
            if lyrics.found?
              success 'Lyrics found'
              run_output
            else
              fatal_error 'No lyric found'
            end
          end

          def start_banner
            infov 'File', file
            %w[artist album track title year].each do |attr|
              infov attr.humanize, container.tag_file.tag.send(attr)
            end
            infov 'Selected provider', provider
          end

          def container_uncached
            ::EhbrsRubyUtils::Videos::File.from_file(file)
          end

          def file
            parsed.file.to_pathname
          end

          def lyrics_uncached
            container.lyrics_by_provider(provider)
          end

          def output_content
            lyrics.text
          end

          def provider_uncached
            ::UltimateLyrics::Provider.by_name(provider_name)
          end

          def provider_name
            parsed.provider
          end
        end
      end
    end
  end
end
