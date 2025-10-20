class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      break if item.name == "Sulfuras, Hand of Ragnaros"

      item.quality = new_quality(item.name, item.sell_in, item.quality)
      item.sell_in = item.sell_in - 1
    end
  end

  private

  def new_quality(item_name, sell_in, quality)
    if item_name == "Aged Brie"
      quality_diff = sell_in > 0 ? 1 : 2
      (quality + quality_diff).clamp(0, 50)
    elsif item_name == "Backstage passes to a TAFKAL80ETC concert"
      return 0 if sell_in < 1

      quality_diff = backstage_passes_quality_diff(sell_in)
      (quality + quality_diff).clamp(0, 50)
    else
      quality_diff = sell_in > 0 ? 1 : 2
      quality - quality_diff
    end
  end

  def backstage_passes_quality_diff(sell_in)
    return 3 if sell_in < 6
    return 2 if sell_in < 11
    1 
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
