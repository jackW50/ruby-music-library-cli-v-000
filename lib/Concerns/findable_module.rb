module Concerns::Findable
  def find_by_name(input) 
    all.detect {|i| i.name == input}
  end 
  
  def find_or_create_by_name(input)
    if find_by_name(input) != nil
      find_by_name(input)
    else 
      create(input)
    end 
  end 
  
end 