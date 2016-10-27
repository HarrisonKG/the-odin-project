# #readlines reads entire file into an array, line by line
lines = File.readlines("text.txt")
# counts size of array
line_count = lines.size 
# joins array into single string
text = lines.join

puts "#{line_count} lines"

total_characters = text.length
puts "#{total_characters} characters"