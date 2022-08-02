require 'date'
require 'objspace'

require './game'
require_relative './genre'
require_relative './music_album'

class App
  attr_reader :status

class App
  def initialize
    @games = []
    @authors = []
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

  def exit_app
    exit
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
