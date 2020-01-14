class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.keys.include?(item)
    end
  end

  def sorted_item_list
    items = @vendors.map do |vendor|
      vendor.inventory.keys
    end
    list = items.flatten.map do |item|
      item.name
    end
    list.uniq.sort
  end

  def total_inventory
    @vendors.each do |vendor|
      vendor.inventory.map do |item, price|
        @inventory[item] += price
      end
    end
  end
end
