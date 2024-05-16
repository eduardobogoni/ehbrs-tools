# frozen_string_literal: true

require 'ehbrs_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/music/sort/commands/base'

module EhbrsRubyUtils
  module Music
    module Sort
      module Commands
        class Load < EhbrsRubyUtils::Music::Sort::Commands::Base
          private

          def run
            info "Reading \"#{root}\"..."
            config = build_config
            s = config.to_yaml
            puts s
            if confirm
              info("Writing to \"#{config_file}\"...")
              File.write(config_file, s)
            end
            puts 'Done!'.green
          end

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
