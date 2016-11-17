require 'sinatra'
require 'sinatra/reloader'


NUMBER = rand(101)


def check_guess(guess)
	if guess == nil
		message = "Please guess a number between 0 and 100"
	elsif guess > NUMBER 
		message = (guess - NUMBER < 10)? "Too high!" : "Way too high!"
	elsif guess < NUMBER
		message = (NUMBER - guess < 10)? "Too low!" : "Way too low!"
	elsif guess == NUMBER
		message = "You guessed correctly!"
	end
end


get '/' do 
	guess = params['guess'].to_i unless params['guess'] == nil
	
	message = check_guess(guess)
	secret = "The secret number is #{NUMBER}" if guess == NUMBER

	erb :index, :locals => {:message => message, :secret => secret}
end


