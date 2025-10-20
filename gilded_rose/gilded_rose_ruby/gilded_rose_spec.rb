# bundle exec rspec gilded_rose_spec.rb
require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe 'アイテムの名前について' do
    it "アイテムの名前が変化しないこと" do
      items = [Item.new("foo", 30, 30)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq("foo")
    end
  end

  describe 'アイテムの販売期限 (sell_in) について' do
    context "販売期限が残り30日の場合" do
      it "sell_in が1減少すること" do
        items = [Item.new("foo", 30, 30)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(29)
      end
    end

    context "販売期限が残り1日の場合" do
      it "sell_in が0になること" do
        items = [Item.new("foo", 1, 30)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(0)
      end
    end

    context "販売期限が残り0日の場合" do
      # TODO: 要仕様確認
      it "sell_in が-1になること" do
        items = [Item.new("foo", 0, 30)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(-1)
      end
    end
  end

  describe 'アイテムの品質 (quality) について' do
    context "通常アイテムの場合" do
      context "販売期限が残り30日の場合" do
        it "quality が1減少すること" do
          items = [Item.new("foo", 30, 30)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(29)
        end
      end

      context "販売期限が残り1日の場合" do
        it "quality が1減少すること" do
          items = [Item.new("foo", 1, 30)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(29)
        end
      end

      context "販売期限が残り0日の場合" do
        it "quality が2減少すること" do
          items = [Item.new("foo", 0, 30)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(28)
        end
      end
    end
  end
end
