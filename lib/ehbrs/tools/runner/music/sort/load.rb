# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Music
        class Sort
          class Load
            runner_with :help, :confirmation

            def run
              info "Reading \"#{path}\"..."
              config = build_config
              s = config.to_yaml
              puts s
              if confirm?
                info("Writing to \"#{config_file}\"...")
                File.write(config_file, s)
              end
              puts 'Done!'.green
            end

            private

            def build_config
              config = {}
              scanner.by_section.each do |section, fs|
                config[section] = fs.sort.map(&:name)
              end
              config
            end
          end
        end
      end
    end
  end
end
