class Song
  extend Concerns::Findable #Take all of the methods in the Findable module and add them as class methods
  extend Persistable::ClassMethods
  include Persistable::InstanceMethods

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  # def save
  #   @@all << self
  # end
  #
  # def self.destroy_all
  #   @@all.clear
  # end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    #reciprocal belongs to
    #First be a nice object and tell the genre that it has a new song, me.
    genre.songs << self unless genre.songs.include?(self)
    #Assign that henre to myself
    @genre = genre
  end

  # def self.find_by_name(name)
  #   self.all.detect {|s| s.name == name}
  # end
  #
  # def self.find_or_create_by_name(name)
  #   self.find_by_name(name) || self.create(name)
  # end

  def self.new_from_filename(filename)
    file = filename.split(" - ")
    artist_name = file[0]
    song_name = file[1]
    genre_name = file [2].gsub(".mp3", "")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    self.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).tap { |s| s.save }
  end

end
