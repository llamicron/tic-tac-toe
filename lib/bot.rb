require_relative "board.rb"

class Bot

  attr_accessor :move

  def initialize
    @move = {
      'row' => nil,
      'column' => nil
    }
  end

  def move(board)
    @move["row"] = rand(0..2)
    @move["column"] = rand(0..2)
    until board.available?(@move)
      @move["row"] = rand(0..2)
      @move["column"] = rand(0..2)
    end
    board.confirm(@move, "O")
    true
  end

end
