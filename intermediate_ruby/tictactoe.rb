class Game
	# winning combinations
	WIN = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

	Player = Struct.new(:name, :symbol)


	def initialize
		# gets player names
		puts "Enter player 1 (X) name:"
		player1 = gets.chomp
		puts "Enter player 2 (O) name:"
		player2 = gets.chomp

		# creates player instances
		@player1 = Player.new(player1, :X)
		@player2 = Player.new(player2, :O)

		# initializes grid array
		@grid = [0,1,2,3,4,5,6,7,8]

		# initializes turn variable
		@current_turn = 1
	end

	# outputs array to screen with three indices in each row
	def show_grid
		puts @grid.each_slice(3) { |row| puts row.join(" . ")}
	end

	# handles the input for each turn
	def turn
		# Queries current player for move and displays grid
		puts "\n#{current_player.name} (#{current_player.symbol}), it's your turn. Where would you like to go?\n"
		show_grid

		# checks if move is valid and updates grid array
		move = gets.chomp.to_i
		if move.between?(0, 8) && @grid.include?(move)
			@grid[move] = current_player.symbol
			@current_turn += 1	
		else
			puts "Invalid move. Please type the number at which you would like to place your #{current_player.symbol}"
		end
	end

	# identifies which player's turn it is to play
	def current_player
		@current_turn.even? ? @player2 : @player1
	end

	# identifies which player just played, to check if won
	def played_last
		@current_turn.even? ? @player1 : @player2
	end

	# evaluates true if any winning combos were played by the last player
	def winner
		WIN.any? {|combo| combo.all? { |i| @grid[i] == played_last.symbol} }
	end

	# plays until a winner or the board is full
	def play
		while !winner && @current_turn < 10
			turn
		end
		result
	end

	# shows game over results; tie or win
	def result
		puts "\n\n"
		show_grid
		if winner
			puts "#{played_last.name} won!"
		else
			puts "You tied!"
		end
		play_again
	end

	def play_again
		puts "Would you like to play again? y/n"
		answer = gets.chomp.downcase

		if answer == "y"
			@grid = [0,1,2,3,4,5,6,7,8]
			@current_turn = 1
			play
		else
			"Thanks for playing!"
		end
	end
end


Game.new.play

#		WIN.any? {|combo| combo.all? { |i| @grid[i] == @grid[combo[0]]} }
