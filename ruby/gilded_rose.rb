# The Gilded Rose Store Inventory
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name == 'Aged Brie'
        item.quality = [item.quality + 1, 50].min
        item.sell_in -= 1
      elsif item.name == 'Sulfuras, Hand of Ragnaros'
        item.quality = 80
      elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
        case item.sell_in
        when (-Float::INFINITY..0)
          item.quality = 0
        when (1..5)
          item.quality += 3
        when (6..10)
          item.quality += 2
        else
          item.quality += 1
        end
        item.sell_in -= 1
      else
        reduction = item.sell_in <= 0 ? 2 : 1
        item.quality = [item.quality - reduction, 0].max
        item.sell_in -= 1
      end
    end
  end
end

# Denotes an item of inventory
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
