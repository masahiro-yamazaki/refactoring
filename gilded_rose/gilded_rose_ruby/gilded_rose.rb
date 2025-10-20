class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      break if item.name == "Sulfuras, Hand of Ragnaros"

      item.quality = new_quality(item)
      item.sell_in = item.sell_in - 1
    end
  end

  private

  def new_quality(item)
    if item.name == "Aged Brie"
      quality_diff = item.sell_in > 0 ? 1 : 2
      (item.quality + quality_diff).clamp(0, 50)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      return 0 if item.sell_in < 1

      quality_diff = backstage_passes_quality_diff(item.sell_in)
      (item.quality + quality_diff).clamp(0, 50)
    else
      quality_diff = item.sell_in > 0 ? 1 : 2
      (item.quality - quality_diff).clamp(0, 50)
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
