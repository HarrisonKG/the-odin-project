module Mastermind

	class Game

		# creates secret code and explains rules
		def initialize
			create_code
			@turns = 1
			@game_over = false

			puts %Q{
\nWelcome to Mastermind! The computer has generated a 4-digit code 
made of numbers between 0 and 5. For each guess you make, the program 
will give you a clue with numbers indicating how correct you were.
A 1 means correct number but in the wrong space, and a 2 means correct 
number and place. The placement of these number clues do not correlate 
to the placement of numbers in our guess. You have 12 guesses! 
Please begin.\n\n}
			end


		def create_code
			# creates random 4-digit code with numbers from 0 to 5
			@code = Array.new(4) {|index| rand(6)}
			#@code = [1,2,1,2]
		end

		def play
			while @turns < 12 && !@game_over
				turn
			end
			if @turns == 12
				puts "\nYou ran out of turns :/ \n"
				play_again
			end
		end



		def turn
			# turns user's guess input into array
			guess = gets.chomp.split(//).map {|s| s.to_i }
			# error checking
			if guess.all? {|i| i.between?(0, 5)}
				# checks accuracy and counts turn
				update_clue(guess)
				@turns += 1
			else
				puts "Invalid submission. Please enter 4 numbers between 0 and 5, such as 1442 or 0530"
			end
		end


		def update_clue(guess)
			#initializes array to build clue
			clue = []

			# checks for number of exact matches
			exact_matches = exact_match(guess)
			# adds a 2 for each exact match
			exact_matches.times { clue << 2 } 

			# checks for number of correct numbers in the wrong place
			semi_matches = semi_match(guess)
			# adds a 1 for each "semi-match"
			semi_matches.times { clue << 1 }

			# check if won
			check_win(clue)
		end


		def check_win(clue)
			# redirect to won if all values are correct
			if clue == [2,2,2,2]
				@game_over = true	
				won
			# gives feedback to user about the accuracy of their guess
			else 
				puts clue.empty? ? "0 matches" : clue.join.to_s
			end
		end


		# returns the number of exact matches
		def exact_match(guess)
			# keeps track of which indices have been matched
			@indices = [0,1,2,3]
			# creates array of the matching indices in guess and @code
			@indices.delete_if {|i| guess[i] == @code[i] }
			# returns number of exact matches
			4 - @indices.length
		end


		# finds total number of "semi-matches" (correct number, incorrect index)
		def semi_match(guess)
			# removes exact matches from guess 
			unmatched = @indices.map {|i| guess[i]}
			# looks at available indices in @code and removes first instance
			# of a number in unmatched for each match made
			@indices.each {
				|i| unmatched.slice!(unmatched.index(@code[i])) if unmatched.include?(@code[i]) 
			}
			# returns number of correct numbers in the incorrect place
			@indices.length - unmatched.length
		end


		def won
			puts "\nYou won!!!\n\n"
			play_again
		end


		def play_again
			puts "Would you like to play again? y/n"
			answer = gets.chomp.downcase
			if answer == "y"
				Game.new.play
			else
				puts "Thank you for playing!\n\n"
			end
		end
	end


	Game.new.play
end


