require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test

  def test_it_exists
    market = Market.new("South Pearl Street Farmers Market")

    assert_instance_of Market, market
  end

  def test_it_has_attributes
    market = Market.new("South Pearl Street Farmers Market")

    assert_equal "South Pearl Street Farmers Market", market.name
    assert_equal [], market.vendors
  end

  def test_add_vendors
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")

    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")

    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal [vendor1, vendor2, vendor3], market.vendors
  end

  def test_vendor_names
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")

    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")

    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"], market.vendor_names
  end

  def test_vendors_that_sell_item
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")

    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")

    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal [vendor1, vendor3], market.vendors_that_sell(item1)
    assert_equal [vendor2], market.vendors_that_sell(item4)
  end

  def test_can_sort_items
    market = Market.new("South Pearl Street Farmers Market")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1 = Vendor.new("Rocky Mountain Fresh")

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")

    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")

    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"], market.sorted_item_list
  end

  def test_total_inventory
    market = Market.new("South Pearl Street Farmers Market")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1 = Vendor.new("Rocky Mountain Fresh")

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")

    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")

    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal ({item1 => 100, item2 => 7, item3 => 50, item4 => 25}), market.total_inventory
  end
end
