# frozen_string_literal: true

module Ehbrs
  module Tools
    module RunnerWith
      module WebUtils
        module Videos
          module FilesRepositoriesSelector
            enable_memoized

            common_concern do
              runner_definition do
                bool_opt '-a', '--all', 'Seleciona todos os repositórios.'
                pos_arg :repository_ids, repeat: true, optional: true
              end
            end

            # @return [Array<Hash>]
            def repositories
              if parsed.all?
                all_repositories
              else
                parsed.repository_ids.map { |id| repository_by_id(id) }
              end
            end

            protected

            # @return [Array<Hash>]
            memoize def all_repositories
              runner_context.call(:instance).videos_files_repositories
            end

            # @param id [String]
            # @return [Hash]
            def repository_by_id(id)
              all_repositories.find { |repository| repository.fetch('id').to_s == id } ||
                fatal_error("Repositório não encontrado: \"#{id}\"")
            end
          end
        end
      end
    end
  end
end
