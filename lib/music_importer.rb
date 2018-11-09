require 'pry'
class MusicImporter
  attr_reader :path 
  
  def initialize(file_path)
    @path = file_path
  end 
  
  def files
    #binding.pry
    Dir.entries(path). select do |file|
      file.match(/.+.mp3/)
    end 
  end 
  
  def import 
    files.each do |filename| 
      Song.create_from_filename(filename)
    end 
  end 
  
  
  
end 
