require 'date'
require 'objspace'
require './game'
require './author'
require './label'
require './book'
require './genre'
require './music_album'

class App
  def initialize
    @labels = []
    @genres = []
    @authors = File.exist?('./resources/authors.json') ? load_resource('authors') : []
    @books = []
    @games = File.exist?('./resources/games.json') ? load_relations(load_resource('games')) : []
    puts 'Welcome to the Catalog of my Things App!'
    puts ''
  end

  def add_music_album
    print 'Song Genre: '
    genre_name = gets.chomp
    print 'Is this song available in Spotify [y/n]: '
    on_spotify = gets.chomp.downcase

    music = MusicAlbum.new(Date.today, on_spotify == 'y')
    genre = Genre.new(genre_name)

    music.add_genre(genre)
  end

  def list_all_genres
    ObjectSpace.each_object(Genre) { |genre| puts genre.name }
  end

  def list_all_music_albums
    ObjectSpace.each_object(MusicAlbum) { |music_album| puts music_album }
  end

  def action(choice, options)
    if choice > options.length || choice.zero?
      (puts 'Invalid option. Please try again.')
    else
      options.each do |option|
        send(option[:action]) if option[:id] == choice
      end
    end
  end

  def list_books
    if @books.empty?
      puts 'There are no books.'
    else
      @books.each do |book|
        puts "ID: #{book.id} - Publisher: \"#{book.publisher}\" - Cover State: #{book.cover_state} "
      end
    end
    puts ''
  end

  def list_labels
    if @labels.empty?
      puts 'There are no labels.'
    else
      @labels.each { |label| puts "ID: #{label.id} - Title: \"#{label.title}\" - Color: #{label.color} " }
    end
    puts ''
  end

  def add_book
    puts 'Please enter the book information'
    print 'Publish Date (YYYY-MM-DD): '
    publish_date = gets.chomp
    print 'Publisher '
    publisher = gets.chomp
    print 'Cover state (good/bad): '
    cover_state = gets.chomp.downcase
    @books << Book.new(publish_date, publisher, cover_state)
    puts 'Book added successfully.'
    puts ''
  end

  def list_games
    puts ''
    puts '╭─✧─≫   List of Games  ≪─✧─╮'
    if @games.empty?
      puts 'There are no games.'
    else
      @games.each { |game| puts "Game with ID #{game.id}" }
    end
    puts ''
  end

  def list_authors
    puts ''
    puts '╭─✧─≫   List of Authors  ≪─✧─╮'
    if @authors.empty?
      puts 'There are no authors.'
    else
      @authors.each { |author| puts "Author with ID #{author.id}" }
    end
    puts ''
  end

  def add_game
    author, label, genre = ask_details('Game')
    puts 'Please enter the information for the game:'
    print 'Publish Date (YYYY-MM-DD): '
    publish_date = gets.chomp
    print 'Multiplayer (y/n): '
    multiplayer = gets.chomp.downcase == 'y'
    print 'Last played at (YYYY-MM-DD): '
    last_played_at = gets.chomp
    game = Game.new(publish_date, last_played_at, multiplayer: multiplayer)
    @games << game
    author && game.add_author(author)
    label && game.add_label(label)
    genre && game.add_genre(genre)
    puts 'Game added successfully.'
    puts ''
  end

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
      return @authors.find(proc {nil}) { |author| author.id == author_id }
    else
      print 'Enter the author first name: '
      first_name = gets.chomp
      print 'Enter the author last name: '
      last_name = gets.chomp
      author = Author.new(first_name, last_name)
      @authors << author
      return author
    end
  end

  def ask_label_details
    list_labels
    print 'Does the label appear in the list above? [y/n]: '
    if gets.chomp.downcase == 'y'
      print 'Enter the label ID: '
      label_id = gets.chomp.to_i
      return @labels.find(poc {nil}) { |label| label.id == label_id }
    else
      print 'Enter the label title: '
      title = gets.chomp
      print 'Enter the label color: '
      color = gets.chomp
      label = Label.new(title, color)
      @labels << label
      return label
    end
  end

  def ask_genre_details
    list_all_genres
    print 'Does the genre appear in the list above? [y/n]: '
    if gets.chomp.downcase == 'y'
      print 'Enter the genre ID: '
      genre_id = gets.chomp.to_i
      return @genres.find { |genre| genre.id == genre_id }
    else
      print 'Enter the genre name: '
      name = gets.chomp
      genre = Genre.new(name)
      @genres << genre
      return genre
    end
  end

  def load_resource(resource)
    JSON.parse(File.read("./resources/#{resource}.json"), create_additions: true)
  end

  def load_relations(items)
    items.each do |item|
      item.add_author(@authors.find { |author| author.id == item.author }) unless item.author.nil?
    end
    items
  end

  def save_resources
    File.write('./resources/authors.json', JSON.generate(@authors))
    File.write('./resources/games.json', JSON.generate(@games))
  end
end
