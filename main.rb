#!/usr/bin/env ruby
require './app'

def main
  options = [
    { id: 4, name: '4 - List of games', action: 'list_games' },
    { id: 7, name: '7 - List all authors', action: 'list_authors' },
    { id: 12, name: '12 - Add a game', action: 'add_game' },
    { id: 13, name: '13 - Exit', action: 'exit_app' }
  ]
  app = App.new
  exit = 0
  while exit.zero?
    puts 'Please choose an option by entering a number:'
    options.each { |option| puts option[:name] }
    choice = gets.chomp.to_i
    choice == 13 ? exit = 1 : app.action(choice, options)
  end
end

main
puts 'Thank you for using this app!'
