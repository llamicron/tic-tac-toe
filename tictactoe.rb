require 'terminal-table'

class Game

  attr_accessor :board

  def initialize
    @board = [
      [" ", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
    # @row1 = Array.new(3, " ")
    # @row2 = Array.new(3, " ")
    # @row3 = Array.new(3, " ")
  end

  public

  def play
    turn = starting_player

    until win do
      clear
      puts "You are X, the bot is O"
      puts draw_board

      if turn == "player"
        player_turn
        turn = "bot"
      else
        bot_turn
        turn = "player"
      end
    end

  end

  private

  def clear
    system "clear" or system "cls"
  end

  def draw_board
    return Terminal::Table.new do |t|
      t.add_row @board[0]
      t.add_separator
      t.add_row @board[1]
      t.add_separator
      t.add_row @board[2]
    end
  end

  def available(move)
    if @board[move["row"]][move["column"]] == " "
      # It is available
      return true
    end
    # It's not available
    return false
  end

  def get_move
    move = {}
    puts "Your turn."
    print "Row (1, 2, 3): "
    move["row"] = gets.chomp.to_i - 1
    print "Column (1, 2, 3): "
    move["column"] = gets.chomp.to_i - 1
    until validate(move)
      puts "Not a valid move, please pick a number between 1 and 3"
      move = get_move
    end
    # Check availability
    until available(move)
      puts "Move not available, try again."
      move = get_move
    end
    return move
  end

  def validate(move)
    move.each do |place, int|
      unless int.is_a? Integer
        return false
      end

      unless int.between?(0, 2)
        return false
      end
    end
    return true
  end

  def player_turn
    move = get_move

    # lots of arrays here lmao
    @board[move["row"]][move["column"]] = "X"
  end

  def bot_turn
    true
  end

  def win
    false
  end

  def starting_player
    if rand(1..2) == 1
      return "player"
    end
    return "bot"
  end

end

def play
  game = Game.new
  game.play
end

play
