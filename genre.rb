class Genre
  attr_reader :items, :name, :id

  def initialize(name, id = rand(500))
    @id = id
    @name = name
    @items = []
  end

  def add_item(item)
    (@items << item) && item.add_genre(self)
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'a' => [name, id]
    }.to_json(*args)
  end

  # Deserialize JSON string by constructing new Foo object with arguments.
  def self.json_create(object)
    new(*object['a'])
  end
end
