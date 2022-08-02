require './game'

class App
  def initialize
    @games = []
    @authors = []
    puts 'Welcome to the Catalog of my Things App!'
    puts ''
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
