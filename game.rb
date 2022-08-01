require './item'
require 'pry'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, last_played_at = nil, multiplayer: false)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  private

  def can_be_archived?
    ((Date.today << 24) <=> @last_played_at).positive? && super
  end
end
