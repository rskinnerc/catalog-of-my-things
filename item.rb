require 'date'

class Item
  attr_accessor :publish_date, :archived, :id, :genre, :label, :author

  def initialize(publish_date)
    @publish_date = publish_date
    @id = rand(500)
    @archived = false
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def add_genre(genre)
    @genre = genre
  end

  def add_label(label)
    @label = label
  end

  def add_author(author)
    @author = author
  end

  private

  def can_be_archived?
    (Date.today << 120 <=> @publish_date).positive?
  end
end
