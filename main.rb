#!/usr/bin/env ruby
require './app'

OPTIONS = [
  { id: 1, name: '1 - List all books', action: 'list_books' },
  { id: 2, name: '2 - list all music albums', action: 'list_all_music_albums' },
  { id: 3, name: '3 - List of games', action: 'list_games' },
  { id: 4, name: '4 - list all genres', action: 'list_all_genres' },
  { id: 5, name: '5 - List all labels', action: 'list_labels' },
  { id: 6, name: '6 - List all authors', action: 'list_authors' },
  { id: 7, name: '7 - Add a book', action: 'add_book' },
  { id: 8, name: '8 - add music album', action: 'add_music_album' },
  { id: 9, name: '9 - Add a game', action: 'add_game' },
  { id: 10, name: '10 - Exit', action: 'exit_app' }
].freeze

def main(options)
  app = App.new
  exit = 0
  while exit.zero?
    puts 'Please choose an option by entering a number:'
    options.each { |option| puts option[:name] }
    choice = gets.chomp.to_i
    choice == 10 ? exit = 1 : app.action(choice, options)
  end
end

main(OPTIONS)
puts 'Thank you for using this app!'
