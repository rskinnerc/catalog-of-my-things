require 'date'

require_relative '../item'

describe Item do
  describe '#move_to_archive' do
    it "Set the item attr archived to true for items older than 10 years" do
      date = Date.new(1987-02-02)

      item = Item.new(date)

      expect(item.archived).to be false
      item.move_to_archive
      expect(item.archived).to be true
    end

    it "does 'not' set archived to true for items 'not' older than 10 years" do
      date = Date.today

      item = Item.new(date)

      expect(item.archived).to be false
      item.move_to_archive
      expect(item.archived).to be false
    end
  end
end