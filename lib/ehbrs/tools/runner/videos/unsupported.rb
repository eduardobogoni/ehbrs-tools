# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Unsupported
          PROFILES = %w[aoc philco samsung].freeze

          runner_with :help do
            desc 'Procura e converte vídeos não suportados pelas TVs de EHB/RS.'
            bool_opt '-f', '--fix', 'Converte vídeos para o formato apropriado.'
            arg_opt '-p', '--profiles', "Seleciona os perfis (#{PROFILES.join(', ')})."
            pos_arg 'paths', repeat: true
          end

          def run
            infov 'Profiles', profiles.join(', ')
            infov 'Paths', paths
            paths.each do |d|
              ::EhbrsRubyUtils::Videos2::Unsupported::Search.new(d, file_options)
            end
          end

          private

          def file_check_set_uncached
            ::EhbrsRubyUtils::Videos2::Unsupported::CheckSet.build(profiles, :file)
          end

          def track_check_set_uncached
            ::EhbrsRubyUtils::Videos2::Unsupported::CheckSet.build(profiles, :track)
          end

          def paths
            parsed.paths
          end

          def file_options
            { file_check_set: file_check_set, track_check_set: track_check_set,
              fix: parsed.fix? }
          end

          def profiles_uncached
            parsed.profiles.if_present(PROFILES) { |v| v.split(',').map(&:strip) }
              .map { |name| profile_class(name).instance }
          end

          def profile_class(profile_name)
            ::EhbrsRubyUtils::Videos2::Unsupported::Profiles.const_get(profile_name.camelize)
          end
        end
      end
    end
  end
end
