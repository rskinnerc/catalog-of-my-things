#!/usr/bin/env ruby
require './app'

def main
  options = [
    { id: 1, name: '1 - List all books', action: 'list_books' },
    { id: 7, name: '7 - Exit', action: 'exit_app' }
  ]
  app = App.new
  exit = 0
  while exit.zero?
    puts 'Please choose an option by entering a number:'
    options.each { |option| puts option[:name] }
    choice = gets.chomp.to_i
    choice == 7 ? exit = 1 : app.action(choice, options)
  end
end

main
puts 'Thank you for using this app!'
