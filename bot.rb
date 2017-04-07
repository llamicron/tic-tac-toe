class Bot
  def move(board)
    move = {}
    move["row"] = rand(0..2)
    move["column"] = rand(0..2)
    until available(move, board)
      move["row"] = rand(0..2)
      move["column"] = rand(0..2)
    end
    return board[move["row"]][move["column"]] = "O"
  end

  def available(move, board)
    if board[move["row"]][move["column"]] == " "
      return true
    end
    false
  end
end
