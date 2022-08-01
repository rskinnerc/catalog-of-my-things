class Item
  attr_reader :date

  def initialize(date)
    @date = date
  end

  private

  def can_be_archived?
    (today.year - date.year) > 10 ? true : false    
  end

end