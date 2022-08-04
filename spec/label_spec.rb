require_relative '../label'

describe Label do
  it 'should have a title and color' do
    label = Label.new('new label', 'red')
    expect(label.title).to eq('new label')
    expect(label.color).to eq('red')
  end

  it 'should have an id' do
    label = Label.new('new label', 'red')
    expect(label.id).to be_a(Integer)
  end

  it 'should have a add_item method to add Items to the items array' do
    label = Label.new('new label', 'red')

    item = double('item')
    allow(item).to receive(:add_label)

    expect(item).to receive(:add_label).with(label)
    label.add_item(item)
    expect(label.items.length).to eq 1
  end
end
