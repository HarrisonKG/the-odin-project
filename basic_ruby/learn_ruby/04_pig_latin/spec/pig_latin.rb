def translate(input)
split_input = input.split
split_input.map! { |word|

case word
when /^([AEIOUaeiou])/
word += "ay"
when /qu/
x= word.split(/([qu].)/)
word = x[2] + x[0] + x[1]+ "ay"
else
x = word.split(/([aeiuoy].*)/)
word = x[1] + x[0] + "ay"
end
}
split_input.join(" ")
end