class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, :through => :line_items

  # can calculate its total
  def total
    self.line_items.map {|line_item| line_item.item.price * line_item.quantity }.sum
  end

  def add_item(item_id)
    new_list_item = self.line_items.find_by(item_id: item_id)
    if new_list_item.present?
      new_list_item.quantity += 1
    else
      new_list_item = self.line_items.build(item_id: item_id)
    end
    new_list_item
  end

end
