require_relative './item'

class Label
  attr_accessor :items, :color, :title

  def initialize(title, color)
    @id = rand(500)
    @title = title
    @color = color
    @items = []
  end

  def add_items(item)
    @items.push(item)
    item.add_label(self)
  end
end
