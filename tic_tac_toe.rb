# Tic-tac-toe game on the command line where two human players can 
# play against each other and the board is displayed in between turns.
# **NOTE** This code is a newbie attempt so its probably a mess and could use better organization.

class Game

	def initialize
		@board = Board.new
		@move_tracker = 0
		@player1 = Player.new("Player 1", [], "X")
		@player2 = Player.new("Player 2", [], "O")
		@current_player = @player1
		$game_over = false
	end

	def play
		@board.draw_board
		turn
	end
	
	private
	
	def turn
		until $game_over do
			current_player
			puts "\n#{@current_player.name}, choose position number on the board for your '#{current_player.symbol}'."
			board_num = gets.chomp.to_i
			symbol = current_player.symbol
			move(board_num, symbol)
			@board.draw_board
			
			@move_tracker += 1
			@current_player.win #check for winner
			@board.board_full? #check if the board is full / tie game.
		end
	end

	def move(board_num, symbol) # processes the players move through the other methods
		if @board.check_move(board_num) == false || (board_num < 1)
			puts "That space is already taken, or an invalid choice."
			puts "Choose an open position."
			board_num = gets.chomp.to_i
			move(board_num, symbol)
		else
			@board.change_board(board_num, symbol)
			@current_player.player_move(board_num) # updates the current players moves array
		end
	end

	def current_player
		@current_player = @move_tracker.even? ? @player1 : @player2
	end

end

class Board

	attr_accessor :arr

	def initialize
		@arr = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
	end

	def draw_board
		puts "\n"
		puts " #{@arr[0]} | #{@arr[1]} | #{@arr[2]}"
		puts "-----------"
		puts " #{@arr[3]} | #{@arr[4]} | #{@arr[5]}"
		puts "-----------"
		puts " #{@arr[6]} | #{@arr[7]} | #{@arr[8]}"
	end

	def check_move(board_num) # checks to see if the board position is already marked.
		if @arr[board_num-1] == "X" || @arr[board_num-1] == "O"
			return false
		else
			return true
		end
	end

	def change_board(position, symbol)
		@arr[position-1] = symbol
	end

	def board_full?
		if @arr.any? { |x| x != "X" && x != "O" } || $game_over
		else
			puts "\nThe board is full so the game is a DRAW."
			$game_over = true
		end
	end

end

class Player
	attr_reader :name, :moves, :symbol

	def initialize(name, moves, symbol)
		@name = name
		@moves = moves
		@symbol = symbol
	end

	WIN_COMBOS = [
		[1,2,3], 
		[4,5,6], 
		[7,8,9], 
		[1,4,7], 
		[2,5,8], 
		[3,6,9], 
		[1,5,9], 
		[3,5,7]
	]

	def player_move(board_num)
		self.moves << board_num
	end

	# Checks to see if a players moves have won the game
	def win
		WIN_COMBOS.each do |x|
			temp_array = []
			x.each do |num|
				if self.moves.include?(num)
					temp_array << num
				end
				if WIN_COMBOS.include?(temp_array)
					puts "\n#{self.name} Wins!! The winning positions are: #{temp_array}"
					$game_over = true
				end
			end
		end
	end

end

game = Game.new
game.play
