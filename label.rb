require_relative './item'

class Label
  attr_reader :id, :items, :color, :title, :items

  def initialize(title, color)
    @id = rand(500)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items.push(item)
    item.add_label(self)
  end
end
