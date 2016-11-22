require 'sinatra'
require 'sinatra/reloader' if development?

TURNS = 15
enable :sessions

	get '/' do 
		if session[:secret_word] == nil
			redirect to('/new_game')
		end
		# guess set to "" if params are empty to avoid nil exception
		guess = params['guess'] ||= ""
		variables
		erb :index, :locals => { :guess => guess, :turns => TURNS }
		# :secret_word => secret_word, :turns_left => @turns_left, :guess_word => guess_word
	end

	get '/new_game' do 
		session[:secret_word] = pick_word
		session[:guess_word] = build_outline
		session[:turns_left] = 15
		session[:guesses] = []
		redirect to('/')
	end

	
helpers do

	def variables
		@turns_left = session[:turns_left]
		@secret_word = session[:secret_word]
		@guesses = session[:guesses]
		@guess_word = session[:guess_word]
	end

		
		def pick_word
			# reads in words from text file, selects the ones between 5-12 letters
			words = File.readlines('wordlist.txt').select do |word| 
				word.strip.length.between?(5, 12) 
			end
			# pick random word from words array
			@secret_word = words.sample.strip.downcase
		end


		def build_outline
			# builds string of underscores to store progression of guesses
			@guess_word = ""
			@secret_word.length.times { @guess_word << "_" }
			@guess_word
		end


		# plays until a win or the player runs out of turns
		def check_win
			while !win && @turns_left >= 0
				turn
			end
			# counter increments at start of turn, so must be less than max turns
			if win
				play_again
			else
				puts "\n Sorry, you ran out of turns. The word was #{@secret_word}"
				play_again
			end
		end


		# accepts one character from user and checks for matches and win
		def turn
			@turns_left -= 1
			@guess_letter = gets[0].downcase
			show_matches
			check_win
		end


		def show_matches
			# iterate through secret word and sub in accurate guesses
			@secret_word.each_char.with_index do |char, index|
				@guess_word[index] = char if char == @guess_letter 
			end
			# prints updated guess with matched letters
			@guess_word.each_char { |char| print " #{char}" }
		end

	
		# win when cumulative guesses equal the secret word
		def win
			@guess_word == @secret_word
		end

	end
