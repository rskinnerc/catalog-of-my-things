require_relative '../genre'

describe @Genre do

  before :each do
    @genre = Genre.new('Rock')
    @item = double('Item')
    allow(@item).to receive(:add_genre)
    allow(@item).to receive(:genre) { @genre }
  end

  describe '#add_item' do
    it 'Adds an item instance to @items collection' do
      expect(@genre.items).to be_empty
      @genre.add_item(@item)
      expect(@genre.items).to include @item
    end

    it 'Has a name attribute' do
      expect(@genre.name).to eql 'Rock'
    end
  end
end