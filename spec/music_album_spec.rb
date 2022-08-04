require_relative '../music_album'

describe MusicAlbum do
  describe '#move_to_archive' do
    it 'Set as archived when older than 10 years AND on_spotify is true' do
      date = Date.new(2010, 2, 2)
      on_spotify = true
      music_album = MusicAlbum.new(date, on_spotify)

      expect(music_album.archived).to be false
      music_album.move_to_archive

      expect(music_album.archived).to be true
    end

    it "Don't set as archived when older than 10 years AND on_spotify is false" do
      date = Date.new(2010, 2, 2)
      on_spotify = false
      music_album = MusicAlbum.new(date, on_spotify)

      expect(music_album.archived).to be false
      music_album.move_to_archive

      expect(music_album.archived).to be false
    end

    it "Don't set as archived when not older than 10 years AND on_spotify is true" do
      date = Date.today << 118
      on_spotify = true
      music_album = MusicAlbum.new(date, on_spotify)

      expect(music_album.archived).to be false
      music_album.move_to_archive

      expect(music_album.archived).to be false
    end
  end
end
