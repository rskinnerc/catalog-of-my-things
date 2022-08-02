require_relative '../book'

describe Book do
  describe '#move_to_archive' do
    it 'archive book when the publish date is more than 10 years AND the cover state is bad' do
      publish_date = Date.new(2010, 3, 4)
      my_book = Book.new(publish_date, 'DAW Books', 'bad')

      expect(my_book.archived).to be false
      my_book.move_to_archive

      expect(my_book.archived).to be true
    end

    it "book can't be archived when publish date less than 10 years AND the cover state is good" do
      publish_date = Date.new(2020, 3, 4)
      my_book = Book.new(publish_date, 'DAW Books', 'good')

      expect(my_book.archived).to be false
      my_book.move_to_archive

      expect(my_book.archived).to be false
    end

    it 'book can be archived when the publish date is older than 10 years AND the cover state is good' do
      publish_date = Date.new(2010, 3, 4)
      my_book = Book.new(publish_date, 'DAW Books', 'good')

      expect(my_book.archived).to be false
      my_book.move_to_archive

      expect(my_book.archived).to be true
    end
  end
end
