require_relative 'item'

class MusicAlbum < Item
  attr_reader :on_spotify

  def initialize(publish_date, on_spotify, id = rand(500))
    super(publish_date, id)
    @on_spotify = on_spotify
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'a' => [publish_date, on_spotify, id]
    }.to_json(*args)
  end

  # Deserialize JSON string by constructing new Foo object with arguments.
  def self.json_create(object)
    new(*object['a'])
  end

  private

  def can_be_archived?
    super() && on_spotify
  end
end
