class Game
	# winning combinations
	WIN = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8]]

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

		@grid = [0,1,2,3,4,5,6,7,8]
		show_grid
	end

	def show_grid
		puts @grid.each_slice(3) { |row| row.join(" . ")}
	end



	

end


Game.new