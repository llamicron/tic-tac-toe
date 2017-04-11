require_relative "board.rb"

class Bot

  attr_accessor :move

  def initialize(board)
    @board = board
    @move = {
      'row' => nil,
      'column' => nil
    }
  end

  def confirm_move
    until @board.available?(@move)
      choose_move
    end
    @board.confirm(@move, "O")
    true
  end

  def choose_move
    if @board.board_empty?
      choose_random_corner
    elsif winning_space
      return true
    end
  end

  def choose_random_corner
    case space = rand(1..4)
    when 1
      @move['row'] = 0
      @move['column'] = 0
      return true
    when 2
      @move['row'] = 0
      @move['column'] = 2
      return true
    when 3
      @move['row'] = 2
      @move['column'] = 0
      return true
    when 4
      @move['row'] = 2
      @move['column'] = 2
      return true
    end
  end

  def winning_space
    row_count = 0
    @board.board.each do |row|
      counter = Hash.new(0)
      row.each do |space|
        counter[space] += 1
      end
      if counter["O"] == 2
        @move['row'] = row_count
        @move['column'] = row.find_index(" ")
        return true
      end
      row_count += 1
    end
    return false
  end

end
