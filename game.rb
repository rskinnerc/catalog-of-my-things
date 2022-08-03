require './item'
require 'json'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, last_played_at = nil, multiplayer: false)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'a' => [id, publish_date, last_played_at, multiplayer, archived, genre&.id, label&.id, author&.id]
    }.to_json(*args)
  end

  def self.json_create(object)
    id, publish_date, last_played_at, multiplayer, archived, genre_id, label_id, author_id = object['a']
    game = new(publish_date, last_played_at, multiplayer: multiplayer)
    game.id = id
    game.archived = archived
    game.genre = genre_id
    game.label = label_id
    game.author = author_id
    game
  end

  private

  def can_be_archived?
    ((Date.today << 24) <=> @last_played_at).positive? && super
  end
end
