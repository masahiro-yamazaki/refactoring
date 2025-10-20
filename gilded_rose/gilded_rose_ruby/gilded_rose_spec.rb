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

    context "Sulfuras, Hand of Ragnaros の場合" do
      it "sell_in が変化しないこと" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 30, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(30)
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

      context "quality が0の場合" do
        it "quality が変化しないこと" do
          items = [Item.new("foo", 30, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end
      end
    end

    context "Sulfuras, Hand of Ragnaros の場合" do
      it "quality が変化しないこと" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 30, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(80)
      end
    end

    context "Aged Brie の場合" do
      context "販売期限が残り30日の場合" do
        context "quality が49以下の場合" do
          it "quality が1増加すること" do
            items = [Item.new("Aged Brie", 30, 49)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end

        context "quality が50の場合" do
          it "quality が増加しないこと" do
            items = [Item.new("Aged Brie", 30, 50)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end
      end

      context "販売期限が残り1日の場合" do
        it "quality が1増加すること" do
          items = [Item.new("Aged Brie", 1, 30)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(31)
        end
      end

      context "販売期限が残り0日の場合" do
        # TODO: 要仕様確認
        it "quality が2増加すること" do
          items = [Item.new("Aged Brie", 0, 30)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(32)
        end
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert の場合" do
      context "販売期限が残り11日の場合" do
        context "quality が49以下の場合" do
          it "quality が1増加すること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 49)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end

        context "quality が50の場合" do
          it "quality が増加しないこと" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end
      end

      context "販売期限が残り10日の場合" do
        context "quality が48以下の場合" do
          it "quality が2増加すること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 48)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end

        context "quality が49の場合" do
          it "quality が50まで増加すること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end
      end

      context "販売期限が残り6日の場合" do
        context "quality が48以下の場合" do
          it "quality が2増加すること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 48)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end

        context "quality が49の場合" do
          it "quality が50まで増加すること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 49)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end
      end

      context "販売期限が残り5日以下の場合" do
        context "quality が47以下の場合" do
          it "quality が3増加すること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 47)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end

        context "quality が48の場合" do
          it "quality が50まで増加すること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 48)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end
      end

      context "販売期限が残り1日の場合" do
        context "quality が47以下の場合" do
          it "quality が3増加すること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 47)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end

        context "quality が48の場合" do
          it "quality が50まで増加すること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 48)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(50)
          end
        end
      end

      context "販売期限が残り0日の場合" do
        context "quality が47以下の場合" do
          it "quality が0になること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 47)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(0)
          end
        end

        context "quality が48の場合" do
          it "quality が0になること" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 48)]
            GildedRose.new(items).update_quality
            expect(items[0].quality).to eq(0)
          end
        end
      end
    end
  end
end
