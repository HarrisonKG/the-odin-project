module Mastermind

	class Game

		# creates secret code and explains rules
		def initialize
			create_code
			@turns = 1
		end
=begin			puts %Q{
nWelcome to Mastermind! The computer has generated a 4-digit code 
made of numbers between 0 and 5. For each guess you make, the program 
will give you a clue with numbers indicating how correct 
you were. A 0 means no matches, a 1 means correct number but in the 
wrong space, and a 2 means correct number and place. The placement 
of these number clues do not correlate to the placement of numbers in 
our guess. You have 12 guesses! Please begin.\n\n}
=end


		def create_code
			# creates random 4-digit code with numbers from 0 to 5
			#@code = Array.new(4) {|index| rand(6)}
			@code = [1,2,1,2]
		end

		def play
			while @turns < 13
				turn
			end
		end



		def turn
			# turns guess input into array
			guess = gets.chomp.split(//).map {|s| s.to_i }
			# error checking
			if guess.all? {|i| i.between?(0, 5)}
				# checks accuracy and counts turn
				check_code(guess)
				@turns += 1
			else
				puts "Invalid submission. Please enter 4 numbers between 0 and 5, such as 1442 or 0530"
			end
		end


		def check_code(guess)
			clue = []
			# keeps track of which indices have been matched
			@indices = [0,1,2,3]
			exact_matches = exact_match(guess)
			# adds a 2 for each exact match
			exact_matches.times { clue << 2 } 

			semi_matches = semi_match(guess)
			# adds a 1 for each "semi-match"
			semi_matches.times { clue << 1 }
			# gives feedback to user about the accuracy of their guess
			puts clue.empty? "0 matches" : clue.to_s
		end


		# returns the number of exact matches
		def exact_match(guess)
			# deletes values in @indexes of the matching indices in guess and @code
			@indices.each {|i| @indices.delete(i) if guess[i] == @code[i] }
			# sums @indices and returns total subtracted from 4 
			return 4 - @indices.length
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
	end


	Game.new.play
end


