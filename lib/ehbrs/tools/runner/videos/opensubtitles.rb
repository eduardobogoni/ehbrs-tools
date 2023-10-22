#!/usr/bin/env ruby
# frozen_string_literal: true

require 'eac_ruby_base0/core_ext'
require 'ehbrs_ruby_utils/videos/opensubtitles/processors/subtitles_provider'

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Opensubtitles
          runner_with :help, :output do
            arg_opt '-C', '--target-path', 'Caminho para extração dos arquivos', default: '.'
            bool_opt '-H', '--html', 'Formata URLs como links HTML.'
            bool_opt '-d', '--download', 'Baixa os links em vez mostrá-los.'
            pos_arg :url
          end

          def run
            parsed.download? ? run_download : run_output
          end

          def run_download
            subtitles.map { |sub| download_sub(sub) }
          end

          def output_content
            subtitles.map { |v| "#{format_url(v.source_uri)}\n" }.join
          end

          private

          def download_sub(sub)
            infov 'Downloading', sub.source_uri
            ::EacRubyUtils::Envs.local.command('wget', '--continue', sub.source_uri).system!
          end

          def subtitles_uncached
            r = subtitles_provider.subtitles
            infov 'Subtitles found', r.count
            r
          end

          def format_url(url)
            return url unless parsed.html?

            "<a href=\"#{url}\">#{url}</a><br/>"
          end

          # @return [EhbrsRubyUtils::Videos::Opensubtitles::Processors::SubtitlesProvider]
          def subtitles_provider_uncached
            ::EhbrsRubyUtils::Videos::Opensubtitles::Processors::SubtitlesProvider
              .new(parsed.url, target_path: parsed.target_path)
          end
        end
      end
    end
  end
end
