def echo(string)
string
end

def shout(string)
string.upcase
end

def repeat(string, num=2)
([string] * num).join(" ")
end

def start_of_word(input, num)
input[0...1]
end

def first_word(string)
string.split(" ").first
end

def titleize(input)
split_input = input.split
split_input.map{|x| x.capitalize! unless x == "and" || x == "over" || x == "the"}
split_input.first.capitalize!
split_input.join(" ")
end
