require_relative "board.rb"

class Bot

  def move(board)
    move = {}
    move["row"] = rand(0..2)
    move["column"] = rand(0..2)
    until board.available?(move)
      move["row"] = rand(0..2)
      move["column"] = rand(0..2)
    end
    board.confirm(move, "O")
  end

end
