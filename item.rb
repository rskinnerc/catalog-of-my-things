require 'date'

class Item
  attr_reader :publish_date, :archived, :id

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
    (Date.today - publish_date).to_i > (Date.today - Date.new(Date.today.year-10,Date.today.month,Date.today.day)).to_i
  end

end