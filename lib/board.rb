require 'terminal-table'

class Board

  attr_accessor :board

  def initialize
    @board = [
      [" ", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
  end

  def draw
    table = Terminal::Table.new do |t|
      t.add_row @board[0]
      t.add_separator
      t.add_row @board[1]
      t.add_separator
      t.add_row @board[2]
    end
    return table
  end

  def available?(move)
    if !move['row'] or !move['column']
      return false
    end
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
    # Lots of arrays here lmao
    @board[move["row"]][move["column"]] = player
    true
  end

  def full?
    @board.each do |row|
      if row.include? " "
        return false
      end
    end
    true
  end

  def vertical_win?
    @board.count.times do |x|
      if cell({'row' => 0, 'column' => x}) != " "
        if @board[0][x] == @board[1][x] and @board[0][x] == @board[2][x]
          winner = @board[0][x]
          return winner
        end
      end
    end
    return false
  end

  def horizontal_win?
    @board.each do |row|
      if row.all? {|x| x == row[0]} and !row.include? " "
        winner = row[0]
        return winner
      end
    end
    return false
  end

  def diagonal_win?
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
    puts draw
    true
  end

  # This method is just a wrapper that checks all win conditions
  def win
    # horizontal win
    winner = horizontal_win?
    if winner
      victory(winner)
      return winner
    end

    # Vertical win (way harder to test for)
    winner = vertical_win?
    if winner
      victory(winner)
      return winner
    end

    # Diagonal win
    winner = diagonal_win?
    if winner
      victory(winner)
      return winner
    end

    # If the board is full and there are no declared winners

    if full?
      victory("Nobody")
      return "tie"
    end
    return false
  end

  def clear
    @board = [
      [" ", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
  end

  def cell(move)
    @board[move['row']][move['column']]
  end

  # These methods are just for testin'
  def set_vertical_win(player="X")
    @board = [
      ["#{player}", " ", " "],
      ["#{player}", " ", " "],
      ["#{player}", " ", " "]
    ]
  end

  def set_horizontal_win(player="X")
    @board = [
      ["#{player}", "#{player}", "#{player}"],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
  end

  def set_diagonal_win_top_left(player="X")
    @board = [
      ["#{player}", " ", " "],
      [" ", "#{player}", " "],
      [" ", " ", "#{player}"]
    ]
  end

  def set_diagonal_win_top_right(player="X")
    @board = [
      [" ", " ", "#{player}"],
      [" ", "#{player}", " "],
      ["#{player}", " ", " "]
    ]
  end

  def fill(winner="X")
    if winner == "tie"
      @board = [
        ["X", "O", "X"],
        ["X", "O", "O"],
        ["O", "X", "X"],
      ]
      return true
    end
    @board = [
      ["#{winner}", "#{winner}", "#{winner}"],
      ["#{winner}", "#{winner}", "#{winner}"],
      ["#{winner}", "#{winner}", "#{winner}"]
    ]
    true
  end

  def board_empty?
    @board.each do |row|
      if row.include? "X" or row.include? "O"
        return false
      end
    end
    true
  end

end
