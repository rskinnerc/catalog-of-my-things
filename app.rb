class App
  def initialize
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
end