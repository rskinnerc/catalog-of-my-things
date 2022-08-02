class Genre
  attr_reader :items, :name

  def initialize(name)
    @id = rand(500)
    @name = name
    @items = []
  end

  def add_item(item)
    (@items << item) && item.add_genre(self)
  end
end
