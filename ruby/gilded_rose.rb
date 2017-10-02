# The Gilded Rose Store Inventory
class GildedRose
  SPECIAL_CASES = {
    'Aged Brie' => :process_brie,
    'Sulfuras, Hand of Ragnaros' => :process_sulfuras,
    'Backstage passes to a TAFKAL80ETC concert' => :process_tickets
  }

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      special_action = SPECIAL_CASES.fetch(item.name, nil)
      if special_action
        send(special_action, item)
      else
        reduction = item.sell_in <= 0 ? 2 : 1
        item.quality = [item.quality - reduction, 0].max
        item.sell_in -= 1
      end
    end
  end

  def process_brie(item)
    item.quality = [item.quality + 1, 50].min
    item.sell_in -= 1
  end

  def process_sulfuras(item)
    item.quality = 80
  end

  def process_tickets(item)
    item.quality = 
      case item.sell_in
      when (-Float::INFINITY..0) then 0
      when (1..5) then item.quality + 3
      when (6..10) then item.quality + 2
      when (11..Float::INFINITY) then item.quality + 1
      end
    item.sell_in -= 1
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
