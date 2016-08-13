class Item < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  has_many :carts, :through => :line_items

  # only returns items with inventory
  def self.available_items
    self.all.select {|item| item.inventory > 0}
  end
end
