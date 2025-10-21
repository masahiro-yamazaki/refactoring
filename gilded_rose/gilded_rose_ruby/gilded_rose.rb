class Item
  attr_accessor :name, :sell_in, :quality
  def initialize(name, sell_in, quality)
    @name, @sell_in, @quality = name, sell_in, quality
  end
  def to_s = "#{@name}, #{@sell_in}, #{@quality}"
end

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      Updater.for(item).update
    end
  end
end

module Rules
  MAX_Q = 50
  MIN_Q = 0

  def dec_sell_in(item) = item.sell_in -= 1
  def inc_q(item, by=1)  = item.quality = [item.quality + by, MAX_Q].min
  def dec_q(item, by=1)  = item.quality = [item.quality - by, MIN_Q].max
end

class Updater
  def self.for(item)
    case item.name
    when "Aged Brie" then AgedBrieUpdater.new(item)
    when "Sulfuras, Hand of Ragnaros" then SulfurasUpdater.new(item)
    when /Backstage passes/ then BackstageUpdater.new(item)
    when /Conjured/ then ConjuredUpdater.new(item) # 拡張（なければ削除）
    else DefaultUpdater.new(item)
    end
  end

  def initialize(item) = @item = item
end

class DefaultUpdater < Updater
  include Rules
  def update
    dec_q(@item, @item.sell_in <= 0 ? 2 : 1)
    dec_sell_in(@item)
  end
end

class AgedBrieUpdater < Updater
  include Rules
  def update
    inc_q(@item, @item.sell_in <= 0 ? 2 : 1)
    dec_sell_in(@item)
  end
end

class SulfurasUpdater < Updater
  # 売却期限も品質も不変
  def update; end
end

class BackstageUpdater < Updater
  include Rules
  def update
    if    @item.sell_in > 10 then inc_q(@item, 1)
    elsif @item.sell_in > 5  then inc_q(@item, 2)
    elsif @item.sell_in > 0  then inc_q(@item, 3)
    else  @item.quality = 0
    end
    dec_sell_in(@item)
  end
end

class ConjuredUpdater < Updater
  include Rules
  def update
    dec_q(@item, @item.sell_in <= 0 ? 4 : 2)
    dec_sell_in(@item)
  end
end
