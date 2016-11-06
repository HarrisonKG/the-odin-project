module Hangman

	class Game

		def initialize
			# reads in words from text file, selects the ones between 5-12 letters
			words = File.readlines("wordlist.txt").select{ |word| word.strip.length.between?(5, 12) }

			# pick random word from array
			@secret_word = words[rand(words.size)].strip.downcase
			puts @secret_word

			@turns = 0

			# builds outline to show guess progression
			@guess_word = ""
			@secret_word.length.times { @guess_word << "_ " }

			# keep track of guesses
			@correct_guesses = []
			@incorrect_guesses = []


			# puts "Welcome to Hangman! There is a secret word you will need to guess."
			# puts "You have 20 turns! Please enter the first letter you want to guess"

		end

		def play
			while !win && @turns < 20
				turn
			end
			result
		end


		def turn
			@guess_letter = gets[0]
			show_matches
		end


		def show_matches
			# iterate through secret word and sub in accurate guesses
			@secret_word.each_char.with_index do
				|char, index| @guess_word[index] = char if char == @guess_letter 
			end
			puts @guess_word
		end


		# win when cumulative guesses equal the secret word
		def win
			@guess_word == @secret_word
		end


		# shows win or loss
		def result
			if win 
				puts "you win!" 
			else
				puts "Sorry, you ran out of turns. The word was #{@secret_word}"
			end
			play_again?
		end


		# asks user if rematch desired
		def play_again?
			puts "Would you like to play again? y/n"
			answer = gets.chomp.downcase
			if answer == ("y" || "yes")
				Game.new.play
			else
				puts "Thank you for playing!"
			end
		end



	end



	Game.new.play
end

