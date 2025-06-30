# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Fs
        class UsedSpace
          runner_with :help do
            desc 'Verifica e anota alterações de espaço usado de um objeto de sistema de arquivos.'
            bool_opt '-c', '--check', 'Anota o espaço em disco.'
            bool_opt '-v', '--verbose', 'Verbose.'
            pos_arg :paths, repeat: true
          end

          def run
            root_banner
            paths.each(&:run)
          end

          def check?
            parsed.check
          end

          private

          def root_banner
            return unless verbose?

            infov 'Paths', paths.count
            infov 'Check?', check?
            infov 'Verbose?', verbose?
          end

          def path_class
            verbose? ? PathVerbose : PathUnverbose
          end

          def paths_uncached
            parsed.paths.map { |path| path_class.new(self, path) }
          end

          def verbose?
            parsed.verbose
          end

          class PathBase
            enable_simple_cache
            enable_speaker
            common_constructor :runner, :path do
              self.path = path.to_pathname
            end

            private

            def last_change_time
              time_label(observer.observer.last_change_time)
            end

            def last_check
              time_label(observer.observer.last_check_time)
            end

            def last_value
              bytes_label(observer.observer.last_value)
            end

            def current_value
              bytes_label(observer.current_value).colorize(
                observer.changing_value? ? :green : :light_black
              )
            end

            def changing_value?
              changing_label(observer.changing_value?)
            end

            def observer_uncached
              ::Ehbrs::Tools::Self::Observers::UsedSpace.new(path)
            end

            def changing_label(bool)
              bool.to_s.colorize(bool ? :green : :light_black)
            end

            def time_label(time)
              time.if_present('-', &:to_s)
            end
          end

          class PathVerbose < PathBase
            def run
              infom path.to_s
              ::EacRubyUtils::Speaker.context.on(::EacCli::Speaker.new(err_line_prefix: '  ')) do
                banner
                check
              end
            end

            private

            def banner
              { 'Path' => observer.path,
                'Persistence path' => observer.persistence_path,
                'Last check' => last_check,
                'Last change' => last_change_time,
                'Last value' => last_value,
                'Current value' => current_value,
                'Changing?' => changing_value? }.each do |k, v|
                infov k, v
              end
            end

            def check
              return unless runner.check?

              infom 'Checking...'
              if observer.check_current_value
                success 'A new value was recorded'
              else
                info 'No new value was recorded'
              end
            end

            def bytes_label(number)
              number.if_present('-') { |v| "#{v} (#{::Filesize.from("#{v} B").pretty})" }
            end
          end

          class PathUnverbose < PathBase
            def run
              self.puts output_line
            end

            def output_line
              [path.to_s.cyan, last_change_time, last_value, current_value, check_result]
                .compact_blank.join('|')
            end

            def check_result
              return nil unless runner.check?

              observer.check_current_value ? 'Recorded'.green : 'Unchanged'.light_black
            end

            def bytes_label(number)
              number.if_present('-') { |v| ::Filesize.from("#{v} B").pretty }
            end

            def time_label(time)
              time.if_present('-') { |t| t.strftime('%d/%m/%y %H:%M') }
            end
          end
        end
      end
    end
  end
end
