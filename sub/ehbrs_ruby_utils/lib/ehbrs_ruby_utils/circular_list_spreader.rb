# frozen_string_literal: true

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
      base_list = ::EhbrsRubyUtils::CircularListSpreader::List.empty
      build_root.pop_all.each do |item|
        base_list = lists_with_item(base_list, item).max
      end
      base_list.items.map(&:item)
    end

    def lists_with_item(base_list, item)
      (base_list.count + 1).times.map do |position|
        base_list.insert(position, item)
      end
    end
  end
end
