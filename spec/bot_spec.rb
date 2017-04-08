require_relative "spec_helper"

describe Bot do

  before :each do
    @board = Board.new
    @bot = Bot.new
  end

  describe ".move" do
    it "chooses a move and confirms it" do
      @board.clear
      expect(@board.board_empty?).to be true
      @bot.move(@board)
      expect(@board.board_empty?).to be false
    end
  end

end
