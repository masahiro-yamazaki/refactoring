# bundle exec rspec gilded_rose_spec.rb
require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

RSpec.describe GildedRose do
  def tick(name, sell_in, quality)
    item = Item.new(name, sell_in, quality)
    GildedRose.new([item]).update_quality
    item
  end

  it "Aged Brie は品質が上がる（上限50）" do
    i = tick("Aged Brie", 1, 49)
    expect([i.sell_in, i.quality]).to eq([0, 50])
  end

  it "Sulfuras は不変" do
    i = tick("Sulfuras, Hand of Ragnaros", 0, 80)
    expect([i.sell_in, i.quality]).to eq([0, 80])
  end

  it "Backstage は期限切れで0" do
    i = tick("Backstage passes to a TAFKAL80ETC concert", 0, 30)
    expect([i.sell_in, i.quality]).to eq([-1, 0])
  end

  it "通常品は期限切れで劣化2倍（下限0）" do
    i = tick("foo", 0, 1)
    expect([i.sell_in, i.quality]).to eq([-1, 0])
  end

  it "Conjured は劣化2倍（期限切れで4）" do
    i = tick("Conjured Mana Cake", 1, 6)
    expect([i.sell_in, i.quality]).to eq([0, 4])
  end
end
