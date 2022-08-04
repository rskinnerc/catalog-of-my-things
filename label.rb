require_relative './item'

class Label
  attr_reader :id, :color, :title, :items

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

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'a' => [id, title, color, items]
    }.to_json(*args)
  end

  def self.json_create(object)
    id, title, color, items = object['a']
    label = new(title, color)
    label.id = id
    label.items = items
    label
  end
end
