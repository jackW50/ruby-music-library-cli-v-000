require 'pry'
class Song 
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist)
    self.genre=(genre)
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.destroy_all
    self.all.clear 
  end 
  
  def save 
    self.class.all << self 
  end 
  
  def self.create(name)
    Song.new(name).tap do |song|
      song.save
    end 
  end 
  
  def artist=(artist)
    @artist = artist 
    artist.add_song(self) unless artist == nil
  end 
  
  def genre=(genre)
    @genre = genre 
    if genre != nil 
      genre.songs << self unless genre.songs.include?(self)
    end 
  end 
  
  def self.find_by_name(input)
    all.detect {|song| song.name == input }
  end 
  
  def self.find_or_create_by_name(input)
    if find_by_name(input) != nil 
      find_by_name(input)
    else 
      create(input)
    end 
  end 
  
  def self.new_from_filename(filename)
    f = filename.split(" - ")
    Song.new(f[1], Artist.find_or_create_by_name(f[0]), Genre.find_or_create_by_name(f[2].gsub(".mp3", "")))
  end 
  
  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end 
  
end 