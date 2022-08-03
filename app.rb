require 'date'
require 'objspace'
require 'json'

require './game'
require './book'
require_relative './genre'
require_relative './music_album'

class App
  def initialize
    @books = []
    @labels = []
    @games = []
    @authors = []
    @genres = []
    @music_albums = []
    puts 'Welcome to the Catalog of my Things App!'
    puts ''
  end
# File managment
  def save
    save_genres
    save_music_albums
  end

  def load_data
    load_genres
    load_music_albums
  end

  def init_file(file)
    File.exist?(file) ? File.open(file) : File.new(file, 'w+')
  end
# loads each object from an (array of json objects) into an array
  def load_items(json, destination_array)
    return if json == ''
    arr = JSON.parse(json, create_additions: true)
    arr.each { |item| destination_array << JSON.parse(item, create_additions: true) }
  end

  def load_genres
    file = init_file('genre.json')

    json = file.read
    load_items(json, @genres)

    file.close
  end

  def load_music_albums
    file = init_file('music_albums.json')

    json = file.read
    load_items(json, @music_albums)

    file.close
  end

  def save_genres
    genre_array = []
    @genres.each { |genre| genre_array << JSON.generate(genre) }
    File.write('genre.json', genre_array)
  end

  def save_music_albums
    music_albums_array = []
    @music_albums.each { |album| music_albums_array << JSON.generate(album) }
    File.write('music_albums.json', music_albums_array)
  end

  def add_music_album
    print 'Song Genre: '
    genre_name = gets.chomp
    print 'Is this song available in Spotify [y/n]: '
    on_spotify = gets.chomp.downcase

    music = MusicAlbum.new(Date.today, on_spotify == 'y')
    genre = Genre.new(genre_name)

    music.add_genre(genre)
    (@genres << genre) && @music_albums << music
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
    puts 'Book added successfully.'
    puts ''
  end

  def list_games
    if @games.empty?
      puts 'There are no games.'
    else
      @games.each { |game| puts "Game with ID #{game.id}" }
    end
    puts ''
  end

  def list_authors
    if @authors.empty?
      puts 'There are no authors.'
    else
      @authors.each { |author| puts "Author with ID #{author.id}" }
    end
    puts ''
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
    puts 'Game added successfully.'
    puts ''
  end
end
