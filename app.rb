require 'date'
require 'objspace'
require 'json'
require './game'
require './author'
require './label'
require './book'
require './genre'
require './music_album'

class App
  def initialize
    @genres = File.exist?('./resources/genres.json') ? load_resource('genres') : []
    @labels = File.exist?('./resources/labels.json') ? load_resource('labels') : []
    @music_albums = File.exist?('./resources/music_albums.json') ? load_resource('music_albums') : []
    @labels = File.exist?('./resources/labels.json') ? load_resource('labels') : []
    @authors = File.exist?('./resources/authors.json') ? load_resource('authors') : []
    @books = File.exist?('./resources/books.json') ? load_resource('books') : []
    @games = File.exist?('./resources/games.json') ? load_resource('games') : []
    puts 'Welcome to the Catalog of my Things App!'
    puts ''
  end

  def add_music_album
    print 'Publish Date (YYYY-MM-DD): '
    publish_date = gets.chomp
    print 'Album Genre: '
    genre_name = gets.chomp
    print 'Is this song available in Spotify [y/n]: '
    on_spotify = gets.chomp.downcase

    music = MusicAlbum.new(Date.parse(publish_date), on_spotify == 'y')
    genre = Genre.new(genre_name)

    music.add_genre(genre)
    @genres << genre
    @music_albums << music
  end

  def list_all_genres
    @genres.each { |genre| print "#{genre.name}, Genre ID: #{genre.id}\n" }
  end

  def list_all_music_albums
    @music_albums.each { |music| print "Almbum ID: #{music.id}\n" }
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
    puts "Book added successfully.\n"
  end

  def list_games
    puts "\n╭─✧─≫   List of Games  ≪─✧─╮\n"
    if @games.empty?
      puts "There are no games.\n"
    else
      @games.each { |game| puts "Game with ID #{game.id}" }
    end
  end

  def list_authors
    puts "\n╭─✧─≫   List of Authors  ≪─✧─╮\n"
    if @authors.empty?
      puts "There are no authors.\n"
    else
      @authors.each { |author| puts "Author with ID #{author.id}" }
    end
  end

  def add_game
    puts 'Please enter the information for the game:'
    print 'Publish Date (YYYY-MM-DD): '
    publish_date = gets.chomp
    print 'Multiplayer (y/n): '
    multiplayer = gets.chomp.downcase == 'y'
    print 'Last played at (YYYY-MM-DD): '
    last_played_at = gets.chomp
    @games << Game.new(publish_date, last_played_at, multiplayer: multiplayer)
    puts "Game added successfully.\n"
  end

  def load_resource(resource)
    JSON.parse(File.read("./resources/#{resource}.json"), create_additions: true)
  end

  def load_relations(items)
    items.each do |item|
      item.add_author(@authors.find { |author| author.id == item.author }) unless item.author.nil?
      item.add_label(@labels.find { |label| label.id == item.label }) unless item.label.nil?
    end
    items
  end

  def save_resources
    File.write('./resources/authors.json', JSON.generate(@authors))
    File.write('./resources/games.json', JSON.generate(@games))
    File.write('./resources/labels.json', JSON.generate(@labels))
    File.write('./resources/books.json', JSON.generate(@books))
    File.write('./resources/genres.json', JSON.generate(@genres))
    File.write('./resources/music_albums.json', JSON.generate(@music_albums))
  end
end
