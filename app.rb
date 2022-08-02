require 'date'
require 'objspace'

require_relative './genre'
require_relative './music_album'

class App
  attr_reader :status

  def initialize
    @status = 'Created'
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
end
