require 'sinatra'
require 'sinatra/reloader' if development?

TURNS = 15
enable :sessions


	get '/' do 
		if session[:secret_word] == nil
			redirect to('/new_game')
		end
		# guess set to "" if params are empty to avoid nil exception
		variables
		turn
		erb :index, :locals => { :turns => TURNS, :game_over => session[:game_over], 
			:turns_left => session[:turns_left]}
		# :secret_word => secret_word, :turns_left => @turns_left, :guess_word => guess_word
	end


	get '/new_game' do 
		session[:secret_word] = pick_word
		session[:guess_word] = build_outline
		session[:turns_left] = 15
		session[:guesses] = []
		result = ""
		redirect to('/')
	end

	
helpers do

	def variables
		session[:guess_letter] = params['guess'] ||= ""
		@secret_word = session[:secret_word]
		@guesses = session[:guesses]
		@guess_word = session[:guess_word]
		@guess_letter = session[:guess_letter]
		session[:game_over] = false
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
		guess_word = ""
		@secret_word.length.times { guess_word << "_" }
		guess_word
	end


	# plays until check_win
	def turn
		@guess_letter = @guess_letter.slice(0) if @guess_letter.length > 1
		# play next turn if still have turns and not won
		if !win && session[:turns_left] > 0
			build_guess_array
			check_letter
		end
		check_win
	end


	def build_guess_array
		# subtract turn and add to array if hasn't been guessed; add to guessed array if isn't in word
		unless @guesses.include? @guess_letter 
			# add to array if not in array and not in secret word (not guessed and wrong)
			@guesses << @guess_letter unless @secret_word.include? @guess_letter
			# subtract from turns if not in array and not in guess word (not guessed)
			session[:turns_left] -= 1 unless @guess_word.include? @guess_letter
		end
	end


	def check_letter
		# iterate through secret word and sub in accurate guesses
			@secret_word.each_char.with_index do |char, index|
			@guess_word[index] = char if char == @guess_letter 
			end
	end


	def check_win
		if win 
			session[:game_over] = true
			@result = "You won!"
		end
		if !win && session[:turns_left] < 1
			session[:game_over] = true
			@result = "Sorry, you ran out of turns. The word was #{@secret_word}." if session[:turns_left] < 1
		end
	end


	def win
		@guess_word.split.join == @secret_word
	end

end
