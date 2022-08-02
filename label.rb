require_relative './item'

class Label
  attr_accessor :items, :color, :title

  def initialize(id, title, color)
    @id = id
    @title = title
    @color = color
    @items = []
  end

  def add_items(item)
    @items.push(item)
    item.add_label(self)
  end
end