require 'pry'
class MusicLibraryController
  attr_accessor :path
  
  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end 
  
  def call 
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To exit, enter 'exit'."
    puts "What would you like to do?"
    
    input = gets.strip
    if input == 'list songs'
      list_songs
      call
    elsif input == 'list artists'
      list_artists
      call
    elsif input == 'list genres'
      list_genres
      call
    elsif input == 'list artist'
      list_songs_by_artist
      call
    elsif input == 'list genre'
      list_songs_by_genre
      call
    elsif input == 'play song'
      play_song
      call
    elsif input == 'exit'
      nil
    else
      call
    end 
  
  end 
  
  def list_songs
    list = Song.all.sort_by {|song| song.name}
    list.each.with_index(1) do |song, i| 
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end 
  end 
  
  def list_artists
    #binding.pry
    list = Artist.all.sort_by {|artist| artist.name}
    list.each.with_index(1) do |artist, i|
      puts "#{i}. #{artist.name}"
    end 
  end 
  
  def list_genres
    list = Genre.all.sort_by {|genre| genre.name}
    list.each.with_index(1) do |genre, i|
      puts "#{i}. #{genre.name}"
    end 
  end 
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if Artist.find_by_name(input) != nil 
      list = Artist.find_by_name(input).songs.sort_by {|song| song.name}
      list.each.with_index(1) do |song, i|
        puts "#{i}. #{song.name} - #{song.genre.name}"
      end 
    else
      nil 
    end 
  end 
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if Genre.find_by_name(input) != nil 
      list = Genre.find_by_name(input).songs.sort_by {|song| song.name}
      list.each.with_index(1) do |song, i|
        puts "#{i}. #{song.artist.name} - #{song.name}"
      end 
    else 
      nil 
    end 
  end 
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i 
    list = Song.all.sort_by {|song| song.name}
    if input.between?(1, list.length)
      song = list[input-1]
      puts "Playing #{song.name} by #{song.artist.name}"
    else
      nil 
    end 
  end 
    
    
    
      

end 