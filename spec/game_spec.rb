require_relative '../game'

describe Game do
  describe '#move_to_archive' do
    it 'sets a game as archived when its older than 10 years and was last played more than 2 years ago' do
      publish_date = Date.new(2010, 2, 2)
      last_played_at = Date.today << 25
      my_game = Game.new(publish_date, last_played_at)

      expect(my_game.archived).to be false
      my_game.move_to_archive

      expect(my_game.archived).to be true
    end

    it "doesn't set a game as archived when older than 10 years AND it was last played no more than 2 years" do
      publish_date = Date.new(2010, 2, 2)
      last_played_at = Date.today << 23
      my_game = Game.new(publish_date, last_played_at)

      expect(my_game.archived).to be false
      my_game.move_to_archive

      expect(my_game.archived).to be false
    end

    it "doesn't set a game as archived when not older than 10 years AND it was last played more than 2 years ago" do
      publish_date = Date.new(2015, 2, 2)
      last_played_at = Date.today << 25
      my_game = Game.new(publish_date, last_played_at)

      expect(my_game.archived).to be false
      my_game.move_to_archive

      expect(my_game.archived).to be false
    end
  end
end
