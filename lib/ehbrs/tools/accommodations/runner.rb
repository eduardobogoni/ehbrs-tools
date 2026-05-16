# frozen_string_literal: true

module Ehbrs
  module Tools
    module Accommodations
      class Runner
        class << self
          # @return [String]
          def organization_name
            module_parent.name.demodulize
          end
        end

        the_class = self

        runner_with :help, :output_list do
          desc "Extrai as acomodações de uma página-lista do #{the_class.organization_name}."
          pos_arg :url
        end

        def run
          run_output
          infov 'Actual count found', list_rows.count
          infov 'Declared count', processor.declared_count
          result, message = counts_result
          send(result, message)
        end

        protected

        # @return [Array]
        def counts_result
          if list_rows.count == processor.declared_count
            [:success, 'Ok!']
          else
            [:warn, 'Actual and declared counts are different']
          end
        end

        # @return [Enumerable<Array<String>>]
        def fields
          self.class.const_get('FIELDS')
        end

        # @return [Class]
        def processor_class
          [self.class.organization_name, 'Processors', 'List']
            .inject(::EhbrsRubyUtils) { |a, e| a.const_get(e) }
        end

        # @return [Object]
        def processor_uncached
          processor_class.new(url)
        end

        # @return [Array<Symbol>]
        def list_columns
          fields.map(&:first)
        end

        # @return [Array<Object>]
        def list_rows
          processor.accommodations
        end

        # @return [Addressable::URI]
        def url
          parsed.url.to_uri
        end
      end
    end
  end
end
