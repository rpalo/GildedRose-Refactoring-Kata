require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq 'foo'
    end

    it 'lowers the quality by one' do
      items = [Item.new('foo', 20, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 19
    end

    it 'lowers the sell-in-days by one' do
      items = [Item.new('foo', 20, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 19
    end

    it 'lowers quality by two if sell-by date is past' do
      items = [Item.new('foo', 0, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 18
    end

    it "doesn't lower quality past zero" do
      items = [Item.new('foo', 20, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it 'raises the quality of "Aged Brie"' do
      items = [Item.new('Aged Brie', 20, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 21
    end

    it "doesn't raise the quality past 50" do
      items = [Item.new('Aged Brie', 20, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "doesn't reduce the sell_in or quality of sulfuras" do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 20, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 20
      expect(items[0].sell_in).to eq 20
    end

    it 'increases quality of "Backstage passes"' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 20, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 21
    end

    it 'increases quality of "Backstage passes" by 2 under 10 days' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 22
    end

    it 'increases quality of "Backstage passes by 3 under 5 days' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 4, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 23
    end

    it 'sets quality to zero after concert' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
  end
end
