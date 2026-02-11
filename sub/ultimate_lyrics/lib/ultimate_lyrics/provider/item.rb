# frozen_string_literal: true

module UltimateLyrics
  class Provider
    class Item
      METHODS_ATTRIBUTES = { tag: :tag, begin_with: :begin, end_with: :end, url: :url }.freeze
      TAG_NAME_PARSER = /<(\w+).*>/.to_parser { |m| m[1] }

      common_constructor :rule, :node

      METHODS_ATTRIBUTES.each do |method_name, attr|
        define_method method_name do
          ::CGI.unescapeHTML(node.attribute(attr.to_s).if_present('', &:text)).presence
        end

        define_method "#{method_name}?" do
          send(method_name).present?
        end
      end

      def delimiters?
        begin_with? || end_with?
      end

      def apply(source)
        %w[url tag delimiters].each do |m|
          next unless send("#{m}?")

          return send("apply_from_#{m}", source)
        end

        raise 'Invalid branch hit'
      end

      def tag_name
        TAG_NAME_PARSER.parse(tag)
      end

      def to_s
        self.class.name.demodulize + '[' + METHODS_ATTRIBUTES
                                           .select { |m, _a| send(m).present? }
                                           .map { |m, a| "#{a}: #{send(m)}" }
                                           .join(', ') +
          ']'
      end
    end
  end
end
