class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, :through => :line_items

  # can calculate its total
  def total
    self.line_items.map {|line_item| line_item.item.price * line_item.quantity }.sum
  end

  # creates a new unsaved line_item for new item
  # creates an appropriate line_item
  # updates existing line_item instead of making new when adding same item
  def add_item(item_id)
    new_list_item = self.line_items.find_by(item_id: item_id)
    if new_list_item.present?
      new_list_item.quantity += 1
    else
      new_list_item = self.line_items.build(item_id: item_id)
    end
    new_list_item
  end

  # subtracts quantity from inventory
  def adjust_inventory
    self.line_items.each do |line_item|
      line_item.item.inventory = line_item.item.inventory - line_item.quantity
      line_item.item.save
    end
  end

  # Change status to submited
  def mark_submited
    self.status = "submitted"
    save
  end

end
