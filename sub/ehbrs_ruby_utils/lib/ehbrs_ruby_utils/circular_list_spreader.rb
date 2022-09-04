# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  class CircularListSpreader
    require_sub __FILE__
    common_constructor :items

    # @return [EhbrsRubyUtils::SpreaderT1::GroupLevel]
    def build_root
      r = ::EhbrsRubyUtils::CircularListSpreader::GroupLevel.new('ROOT')
      items.each { |item| r.push(item.to_circular_list_spreader_path, item) }
      r
    end

    # @return [Array]
    def result
      build_root.pop_all
    end
  end
end
