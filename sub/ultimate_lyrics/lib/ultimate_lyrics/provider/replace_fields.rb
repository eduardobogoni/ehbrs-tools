# frozen_string_literal: true

module UltimateLyrics
  class Provider
    class ReplaceFields
      common_constructor :metadata, :source_string

      def result
        fields_found.inject(source_string) { |a, e| a.gsub("{#{e}}", metadata.send(e)) }
      end
    end
  end
end
