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
    @board.confirm(@move, "O")
    true
  end

  def choose_move
    winning_space
    blocking_space
    choose_empty_corner
    choose_empty_space
    true
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
        confirm_move

      end
      row_count += 1
    end
    false
  end

  def blocking_space
    # Same as winning, but it checks for Xs instead of Os
    row_count = 0
    @board.board.each do |row|
      counter = Hash.new(0)
      row.each do |space|
        counter[space] += 1
      end
      if counter["X"] == 2
        @move['row'] = row_count
        @move['column'] = row.find_index(" ")
        confirm_move

      end
      row_count += 1
    end
    return false
  end

  def choose_empty_corner
    until @board.available?(@move)
      case space = rand(1..4)
      when 1
        @move['row'] = 0
        @move['column'] = 0
      when 2
        @move['row'] = 0
        @move['column'] = 2
      when 3
        @move['row'] = 2
        @move['column'] = 0
      when 4
        @move['row'] = 2
        @move['column'] = 2
      end
    end
    confirm_move

  end

  def choose_empty_space
    until @board.available?(@move)
      @move['row'] = rand(0..2)
      @move['column'] = rand(0..2)
    end
    confirm_move
    
  end

end
