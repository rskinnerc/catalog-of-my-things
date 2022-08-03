module Helpers
  def ask_details(item_type)
    print "Does your #{item_type} have an author? [y/n]: "
    has_author = gets.chomp.downcase == 'y'
    print "Does your #{item_type} have a label? [y/n]: "
    has_label = gets.chomp.downcase == 'y'
    print "Does your #{item_type} have a genre? [y/n]: "
    has_genre = gets.chomp.downcase == 'y'
    author = has_author ? ask_author_details : nil
    label = has_label ? ask_label_details : nil
    genre = has_genre ? ask_genre_details : nil
    [author, label, genre]
  end

  def ask_author_details
    list_authors
    print 'Does the author appear in the list above? [y/n]: '
    if gets.chomp.downcase == 'y'
      print 'Enter the author ID: '
      author_id = gets.chomp.to_i
      @authors.find(proc {}) { |author| author.id == author_id }
    else
      print 'Enter the author first name: '
      first_name = gets.chomp
      print 'Enter the author last name: '
      last_name = gets.chomp
      author = Author.new(first_name, last_name)
      @authors << author
      author
    end
  end

  def ask_label_details
    list_labels
    print 'Does the label appear in the list above? [y/n]: '
    if gets.chomp.downcase == 'y'
      print 'Enter the label ID: '
      label_id = gets.chomp.to_i
      @labels.find(poc { nil }) { |label| label.id == label_id }
    else
      print 'Enter the label title: '
      title = gets.chomp
      print 'Enter the label color: '
      color = gets.chomp
      label = Label.new(title, color)
      @labels << label
      label
    end
  end

  def ask_genre_details
    list_all_genres
    print 'Does the genre appear in the list above? [y/n]: '
    if gets.chomp.downcase == 'y'
      print 'Enter the genre ID: '
      genre_id = gets.chomp.to_i
      @genres.find { |genre| genre.id == genre_id }
    else
      print 'Enter the genre name: '
      name = gets.chomp
      genre = Genre.new(name)
      @genres << genre
      genre
    end
  end
end
