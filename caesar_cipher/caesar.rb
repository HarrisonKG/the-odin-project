#cipher method preserves case by looping
#back to beginning of alphabet after z
def caesar_cipher(text, cipher)
  text.scan(/./) { |symbol|
  	if symbol.between?("a", "z")
	  	ascii = symbol.ord + cipher%26
	  	ascii-=26 if ascii > 122 
	  	print ascii.chr
	elsif symbol.between?("A", "Z")
	  	ascii = symbol.ord + cipher%26
	  	ascii-=26 if ascii > 90 
	  	print ascii.chr
	 else 
	 	print symbol
	 end
  }
  print "\n"
end

#obtain plaintext message
puts "Please enter a string to encode:"
text = gets.chomp

#obtain shift factor
puts "By what index would you like to shift?"
cipher = gets.chomp

#run plaintext through cipher and display result
caesar_cipher(text, cipher.to_i)

