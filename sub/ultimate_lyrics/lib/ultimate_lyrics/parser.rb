# frozen_string_literal: true

module UltimateLyrics
  class Parser
    common_constructor :provider, :original_content

    def original_content_invalid?
      provider.invalid_indicators.any? { |v| original_content.include?(v) }
    end

    def result
      return nil if original_content_invalid?

      sanitize_text(provider.rules.inject(original_content) { |a, e| e.apply(a) })
    end

    def sanitize_text(text)
      r = text.to_s.gsub("\t", ' ').gsub("\r", '').gsub(/ +/, ' ').gsub(/\n{2,}/m, "\n\n").strip
      r.present? ? "#{r}\n" : nil
    end

    def url?
      provider.extract_rules.any?(&:url?)
    end
  end
end
