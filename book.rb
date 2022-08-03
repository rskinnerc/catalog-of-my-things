require_relative './item'
require 'json'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publish_date, publisher, cover_state)
    super(publish_date)
    @publisher = publisher
    @cover_state = cover_state
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'a' => [id, publish_date, publisher, cover_state, archived, genre&.id, label&.id, author&.id]
    }.to_json(*args)
  end

  def self.json_create(object)
    id, publish_date, publisher, cover_state, archived, genre_id, label_id, author_id = object['a']
    book = new(publish_date, publisher, cover_state)
    book.id = id
    book.archived = archived
    book.genre = genre_id
    book.label = label_id
    book.author = author_id
    book
  end

  private

  def can_be_archived?()
    super || @cover_state == 'bad'
  end
end
