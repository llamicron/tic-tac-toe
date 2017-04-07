require 'terminal-table'
require 'rainbow'

class Board

  attr_accessor :board

  def initialize
    @board = [
      [" ", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
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

  def draw
    table = Terminal::Table.new do |t|
      t.add_row @board[0]
      t.add_separator
      t.add_row @board[1]
      t.add_separator
      t.add_row @board[2]
    end
    puts table
  end

  def available?(move)
    if @board[move["row"]][move["column"]] == " "
      # It is available
      return true
    end
    # It's not available
    return false
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

  def confirm(move, player="X")
    @board[move["row"]][move["column"]] = player
    true
  end

  def full?
    @board.each do |row|
      if row.include? " "
        return false
      end
    end
    puts "Tie"
    # Draw the board, not draw the game
    draw
    abort
  end

  def vertical_win
    @board.count.times do |x|
      if !cell_empty?(@board[0][x])
        if @board[0][x] == @board[1][x] and @board[0][x] == @board[2][x]
          winner = @board[0][x]
          return winner
        end
      end
    end
    return false
  end

  def horizontal_win
    @board.each do |row|
      if row.all? {|x| x == row[0]} and !row.include? " "
        winner = row[0]
        return winner
      end
    end
    return false
  end

  def diagonal_win
    # Negative diagonal win (up-left to down-right)
    if @board[0][0] != " "
      if @board[0][0] == @board[1][1] and @board[1][1] == @board[2][2]
        winner = @board[0][0]
        return winner
      end
    end

    # Positive diagonal win (down-left to up-right)
    if @board[2][0] != " "
      if @board[2][0] == @board[1][1] and @board[1][1] == @board[0][2]
        winner = @board[2][0]
        return winner
      end
    end

    return false
  end

  def victory(winner)
    puts "#{winner} wins"
    puts "----------------"
    draw
    abort
  end

  def win
    # horizontal win
    winner = horizontal_win
    if winner
      victory(winner)
    end

    # Vertical win (way harder to test for)
    winner = vertical_win
    if winner
      victory(winner)
    end

    # Diagonal win
    winner = diagonal_win
    if winner
      victory(winner)
    end

    # If the board is full and there are no declared winners
    full?

    return false
  end

  def cell_empty?(cell)
    if cell == " "
      return true
    end
    return false
  end

end
