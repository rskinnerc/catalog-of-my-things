require_relative '../author'

describe Author do
  it 'should have a first_name and last_name' do
    author = Author.new('Stephen', 'King')
    expect(author.first_name).to eq('Stephen')
    expect(author.last_name).to eq('King')
  end

  it 'should have an id' do
    author = Author.new('Stephen', 'King')
    expect(author.id).to be_a(Integer)
  end

  it 'should have a add_item method to add Items to the items array' do
    author = Author.new('Stephen', 'King')

    item = double('item')
    allow(item).to receive(:add_author)

    expect(item).to receive(:add_author).with(author)
    author.add_item(item)
    expect(author.items.length).to eq 1
  end
end
