require 'terminal-table'

class Game

  attr_accessor :board

  def initialize
    @board = [
      [" ", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
  end

  public

  def play
    turn = starting_player

    until win do
      clear
      puts "You are X, the bot is O"
      draw_board

      # If the final play wins the game, the board will be full.
      # The `win` called above will catch that and not let this be triggered
      if board_full
        puts "Tie"
        abort
      end

      if turn == "player"
        player_turn
        turn = "bot"
      else
        bot_turn
        turn = "player"
      end
    end

  end

  # This is just for testin'
  def fill
    @board = [
      ["X", "X", "X"],
      ["X", "X", "X"],
      ["X", "X", "X"]
    ]
    true
  end

  private

  def clear
    system "clear" or system "cls"
  end

  def draw_board
    table = Terminal::Table.new do |t|
      t.add_row @board[0]
      t.add_separator
      t.add_row @board[1]
      t.add_separator
      t.add_row @board[2]
    end
    puts table
  end

  def available(move)
    if @board[move["row"]][move["column"]] == " "
      # It is available
      return true
    end
    # It's not available
    return false
  end

  def board_full
    @board.each do |row|
      if row.include? " "
        return false
      end
    end
    return true
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
    # horizontal win
    @board.each do |row|
      if row.all? {|x| x == row[0]} and !row.include? " "
        puts "#{row[0]} wins"
        draw_board
        abort
      end
    end
    # Vertical win (way harder to test for)
    @board.count.times do |x|
      if !cell_empty?(@board[0][x])
        if @board[0][x] == @board[1][x] and @board[0][x] == @board[2][x]
          puts "#{@board[0][x]} wins"
          draw_board
          abort
        end
      end
    end

    return false
  end

  def starting_player
    if rand(1..2) == 1
      return "player"
    end
    return "bot"
  end

  def cell_empty?(cell)
    if cell == " "
      return true
    end
    return false
  end

  public

end

def play
  game = Game.new
  game.play
end

play
