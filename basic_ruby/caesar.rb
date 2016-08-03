# converts and prints out letters and loops from z back to a
def letter_shift(symbol, cipher, z_int)
  ascii = symbol.ord + cipher%26
  ascii-=26 if ascii > z_int 
  print ascii.chr
end

# determines alphabetic case, prints if non-letter
def caesar_cipher(text, cipher)
  text.scan(/./) do |symbol|
  	if symbol.between?("a", "z")
	  	letter_shift(symbol, cipher, 122)
	elsif symbol.between?("A", "Z")
	  	letter_shift(symbol, cipher, 90)
	 else 
	 	print symbol
	 end
  end
  print "\n"
end



# obtain plaintext message
puts "Please enter a string to encode:"
text = gets.chomp

# obtain shift factor
puts "By what index would you like to shift?"
cipher = gets.chomp

# run plaintext through cipher and display result
caesar_cipher(text, cipher.to_i)

