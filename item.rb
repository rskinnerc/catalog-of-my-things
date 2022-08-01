require 'date'

class Item
  attr_reader :publish_date, :archived

  def initialize(publish_date)
    @publish_date = publish_date
    @id = rand(500)
    @archived = false
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    (Date.today.year - publish_date.year) > 10 ? true : false    
  end

end