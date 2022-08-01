class App
  attr_reader :status

  def initialize
    @status = 'Created'
  end

  def exit_app
    exit
  end
end
