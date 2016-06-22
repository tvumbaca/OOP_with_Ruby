class Game

  def initialize
    @code = []
    @guess = []
    @guess_board = []
    @pegs_board = [ [], [], [], [], [], [], [], [], [], [], [], [] ]
    @counter = 0
    @win = false
    @black_peg = []
    @white_peg = []
  end

  def play
    welcome
    # generates the random 4 letter code
    4.times { @code << ["Y", "B", "G", "O", "P", "R"].sample } 
    while !@win do
      turn
    end 
  end

  def welcome
    puts "\nWelcome to Mastermind!"
    puts "To play, you will need to guess the four color/letter code in 12 turns or less."
    puts "After each turn you will see your most recent guess followed by Peg hints."
    puts "'B' stands for Black Peg. This means one of your choices was the correct color AND position."
    puts "'W' stands for White Peg. This means one of your choices was the correct color BUT in the wrong position."
  end

  def turn
    if @counter > 11
      abort("\nYou did not figure out the code in 12 tries. YOU LOSE!!!\nThe code was: #{@code.join}\n\n")
    end
    puts "\nEnter your 4 peg colors. Choose from: Blue(B), Yellow(Y), Green(G), Orange(O), Purple(P) and Red(R)."
    @guess = gets.chomp.upcase.scan(/\w/)
    if @guess.length == 4 && @guess.all? { |x| x =~ /[BGOPYR]/ }
      @guess_board << @guess
      compare
      if @win == true
        abort("\nYOU WIN!!! You solved the code!\n\n")
      end
      print_board
      @counter += 1 
    elsif
      puts "\nYour guess is Not valid. It needs to be 4 valid letters. Please try again"
    end 
  end

  def compare
    if @code == @guess
      @win = true
    else
      # resets the variables with each turn
      @code_copy = @code.dup
      @guess_copy = @guess.dup
      @black_peg = []
      @white_peg = []
      # finds all the black peg matches
      @guess_copy.each_with_index { |item, index| 
        if item == @code_copy[index]
          @pegs_board[@counter] << "B"
          @code_copy[index] = nil
          @guess_copy[index] = "X"
        end
      }
      # finds all the white peg matches
      @guess_copy.each { |item| 
        if item == @code_copy[0]
          @pegs_board[@counter] << "W"
          @code_copy[0] = nil
        elsif item == @code_copy[1]
          @pegs_board[@counter] << "W"
          @code_copy[1] = nil
        elsif item == @code_copy[2]
          @pegs_board[@counter] << "W"
          @code_copy[2] = nil
        elsif item == @code_copy[3]
          @pegs_board[@counter] << "W"
          @code_copy[3] = nil
        end
      }
    end
  end

  def print_board
    puts "\n TURN ||   GUESS   || PEG HINTS"
    puts "-------------------------------"
    @guess_board.each_with_index { |item, index|
      print " #{index+1}    ||  #{item.join(" ")}  || Pegs: #{@pegs_board[index].join(" ")} \n"
    }
  end

end

game = Game.new
game.play
