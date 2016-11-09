module Hangman

	class Game

		# variable to set total number of turns
		TURNS = 15


		def initialize
			pick_word
			build_outline
			@turns = 0
			puts "\n Welcome to Hangman! There is a secret word you will need to guess."
			puts " You have #{TURNS} turns! Please enter the first letter you want to guess"
		end


		def pick_word
			# reads in words from text file, selects the ones between 5-12 letters
			words = File.readlines("wordlist.txt").select do |word| 
				word.strip.length.between?(5, 12) 
			end
			# pick random word from words array
			@secret_word = words[rand(words.size)].strip.downcase
		end


		def build_outline
			# builds string of underscores to store progression of guesses
			@guess_word = ""
			@secret_word.length.times { @guess_word << "_" }
		end


		# plays until a win or the player runs out of turns
		def play
			while !win && @turns < TURNS
				turn
			end
			# counter increments at start of turn, so must be less than max turns
			if @turns >= TURNS
				puts "\n Sorry, you ran out of turns. The word was #{@secret_word}"
				play_again
			end
		end


		# accepts one character from user and checks for matches and win
		def turn
			@turns += 1
			@guess_letter = gets[0]
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


		# shows win or remaining turns
		def check_win
			if win
				puts "\n You win!" 
				play_again
			else
				# shows how many turns remain
				puts "\n You have #{TURNS - @turns} turns left"
			end
		end


		# asks user if rematch desired
		def play_again
			puts "\n Would you like to play again? y/n"
			answer = gets.chomp.downcase

			if answer == ("y" || "yes")
				Game.new.play
			else
				puts "\n Thank you for playing!"
			end
		end

	end


	Game.new.play
end

