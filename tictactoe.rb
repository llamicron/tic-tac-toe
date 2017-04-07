require_relative "bot.rb"
require_relative "board.rb"

class Game

  attr_accessor :bot, :board

  def initialize
    @board = Board.new
    @bot = Bot.new
  end

  public

  def play
    turn = starting_player

    until @board.win do
      clear
      puts "You are X, the bot is O"
      @board.draw

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

  def get_move
    move = {}
    puts "Your turn."
    print "Row (1, 2, 3): "
    move["row"] = gets.chomp.to_i - 1
    print "Column (1, 2, 3): "
    move["column"] = gets.chomp.to_i - 1
    until @board.validate(move)
      puts "Not a valid move, please pick a number between 1 and 3"
      move = get_move
    end
    # Check availability
    until @board.available?(move)
      puts "Move not available, try again."
      move = get_move
    end
    return move
  end

  def player_turn
    move = get_move

    # lots of arrays here lmao
    @board.confirm(move)
  end

  def bot_turn
    @bot.move(@board)
  end

  def starting_player
    if rand(1..2) == 1
      return "player"
    end
    return "bot"
  end

end

game = Game.new
game.play
