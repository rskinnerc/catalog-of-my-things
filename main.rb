#!/usr/bin/env ruby
require './app'

OPTIONS = [
  { id: 1, name: '1 - ', action: '' },
  { id: 2, name: '2 - ', action: '' },
  { id: 3, name: '3 - ', action: '' },
  { id: 4, name: '4 - List of games', action: 'list_games' },
  { id: 5, name: '5 - ', action: '' },
  { id: 6, name: '6 - ', action: '' },
  { id: 7, name: '7 - List all authors', action: 'list_authors' },
  { id: 8, name: '8 - ', action: '' },
  { id: 9, name: '9 - ', action: '' },
  { id: 10, name: '10 - ', action: '' },
  { id: 11, name: '11 - ', action: '' },
  { id: 12, name: '12 - Add a game', action: 'add_game' },
  { id: 13, name: '13 - Exit', action: 'exit_app' }
].freeze

def main(options)
  app = App.new
  exit = 0
  while exit.zero?
    puts 'Please choose an option by entering a number:'
    options.each { |option| puts option[:name] }
    choice = gets.chomp.to_i
    choice == 13 ? exit = 1 : app.action(choice, options)
  end
end

main(OPTIONS)
puts 'Thank you for using this app!'
