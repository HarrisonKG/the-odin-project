
class Book
	attr_reader :title
	

def title=(input)
  split_input = input.split(" ")
  split_input.map do|x|
	unless ["and", "a", "an", "the", "in", "or", "of"].include? x
	  x.capitalize!
	end 
  end
    title = split_input.join(" ")
    @title = title.slice(0,1).capitalize + title.slice(1..-1)

end

end

