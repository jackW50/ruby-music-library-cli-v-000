class Artist 
  extend Concerns::Findable
  
  attr_accessor :name, :songs 
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
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
    Artist.new(name).tap do |artist|
      artist.save
    end 
  end 
  
  def add_song(song)
    self.songs << song unless songs.include?(song)
    song.artist = self if song.artist == nil
  end 
  
  def genres 
    songs.collect {|song| song.genre}.uniq 
  end 

end 