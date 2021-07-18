# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs/videos/extract/package'

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Extract
          require_sub __FILE__

          DEFAULT_QUALITIES = %w[1080 720 web webrip hdtv].freeze

          runner_with :help do
            desc 'Extrai arquivos de seriados.'
            arg_opt '-d', '--dir', 'Extraí para diretório.'
            bool_opt '-D', '--delete', 'Remove o pacote após o processamento.'
            arg_opt '-q', '--qualities', 'Lista de qualidades.'
            pos_arg 'packages', repeat: true
          end

          def run
            start_banner
            packages.each do |package|
              infov 'Package', package
              package.run(parsed.delete?)
            end
          end

          private

          def packages_uncached
            parsed.packages?.map do |p|
              ::Ehbrs::Videos::Extract::Package.new(p, target_dir, qualities)
            end
          end

          def qualities_uncached
            (parsed.qualities.to_s.split(',') + DEFAULT_QUALITIES).uniq
          end

          def start_banner
            infov 'Packages', packages.count
            infov 'Qualities', qualities
            infov 'Target directory', target_dir
          end

          def target_dir_uncached
            parsed.dir.if_present(&:to_pathname) || default_target_dir
          end

          def default_target_dir
            r = parsed.packages.first.to_pathname.basename('.*')
            return r unless r.exist?

            r = r.basename_sub { |b| "#{b}_extract" }
            index = 0
            loop do
              return r unless r.exist?

              index += 1
              r = r.basename_sub { |b| "#{b}_#{index}" }
            end
          end
        end
      end
    end
  end
end
