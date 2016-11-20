require 'sinatra'
require 'sinatra/reloader'

# determines alphabetic case, prints if non-letter
def caesar_cipher(text, cipher)
  encrypted = text.split('').map do |char|
  	if char.between?("a", "z")
	  	char = letter_shift(char, cipher, 122)
	elsif char.between?("A", "Z")
	  	char = letter_shift(char, cipher, 90)
	else 
	 	char
	end
  end
  return encrypted.join
end


def letter_shift(char, cipher, z_code)
  ascii = char.ord + cipher%26
  ascii-=26 if ascii > z_code 
  return ascii.chr
end


get '/' do 
	# plaintext set to "" if params are empty to avoid nil exception
	plaintext = params['plaintext'] ||= ""
	cipher = params['cipher'].to_i
	
	ciphertext = caesar_cipher(plaintext, cipher)

	erb :index, :locals => {:ciphertext => ciphertext}

end