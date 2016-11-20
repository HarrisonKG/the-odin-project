require 'sinatra'
require 'sinatra/reloader'

# determines alphabetic case, prints if non-letter
def caesar_cipher(text, cipher)
  text.scan(/./) do |char|
  	if char.between?("a", "z")
	  	letter_shift(char, cipher, 122)
	elsif char.between?("A", "Z")
	  	letter_shift(char, cipher, 90)
	 else 
	 	return char
	 end
  end
end


def letter_shift(char, cipher, z_int)
  ascii = char.ord + cipher%26
  ascii-=26 if ascii > z_int 
  return ascii.chr
end


get '/' do 
	plaintext = params['plaintext']
	cipher = params['cipher'].to_i
	
	ciphertext = caesar_cipher(plaintext, cipher)

	erb :index, :locals => {:ciphertext => ciphertext}

end