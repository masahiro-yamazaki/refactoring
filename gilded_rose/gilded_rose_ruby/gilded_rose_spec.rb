# bundle exec rspec gilded_rose_spec.rb
require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe 'アイテムの名前について' do
    it "アイテムの名前が変化しないこと" do
      items = [Item.new("foo", 30, 30)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end
  end

  describe 'アイテムの販売期限 (sell_in) について' do
    it "sell_in が1減少すること" do
      items = [Item.new("foo", 30, 30)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 29
    end
  end
end
