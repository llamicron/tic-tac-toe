require_relative "spec_helper"

describe Board do

  before :each do
    @board = Board.new
    @move = {'row' => 1, 'column' => 1}
    @to_high_move = {'row' => 6, 'column' => 12398734234}
    @string_move = {'row' => "Hello fren here is a string", 'column' => 'string agen fren'}
  end

  describe "#new" do
    it "has a @board array" do
      expect(@board.board).to be_an_instance_of Array
      expect(@board.board).to include([" ", " ", " "])
    end
  end

  # This is a testing method, it won't see much use out in the wild (lmao, it's tic tac toe, not nasa)
  describe ".fill" do
    it "fills the board with Xs" do
      @board.fill
      expect(@board.board).to include(["X", "X", "X"])
    end
  end

  describe ".draw" do
    it "draws a game board" do
      expect(@board.draw).to be_an_instance_of Terminal::Table
    end
  end

  describe ".available" do
    context "when the move is available" do
      it "returns true" do
        expect(@board.available?(@move)).to be true
      end
    end

    context "when the move is not available" do
      it "returns false" do
        # Confirm that move to make the space un-available
        @board.confirm(@move)
        expect(@board.available?(@move)).to be false
      end
    end
  end

  describe ".validate" do
    context "when the move is valid" do
      it "returns true" do
        expect(@board.validate(@move)).to be true
      end
    end

    context "when the move is not valid" do
      it "returns false" do
        expect(@board.validate(@to_high_move)).to be false
        expect(@board.validate(@string_move)).to be false
      end
    end
  end

  describe ".confirm" do
    it "sets the given space to an X or an O" do
      @board.confirm(@move, "O")
      expect(@board.cell(@move)).to eq("O")
    end
  end

  describe ".cell" do
    it "returns an X, O, or blank space" do
      @board.confirm(@move, "X")
      expect(@board.cell(@move)).to eq("X")
      @board.clear
      expect(@board.cell(@move)).to eq(" ")
    end
  end

  describe ".full?" do
    context "when the board is full" do
      it "returns true" do
        @board.fill
        expect(@board.full?).to be true
      end
    end

    context "when the board is not full" do
      it "returns false" do
        @board.clear
        expect(@board.full?).to be false
      end
    end
  end

  describe "win conditions" do

    describe ".vertical_win?" do
      context "when there is a vertical winner" do
        it "returns the winner" do
          #This method is just for testing, to make this more concise
          @board.set_vertical_win("X")
          expect(@board.vertical_win?).to eq("X")
        end
      end

      context "when there is no vertical winner" do
        it "returns false" do
          @board.clear
          expect(@board.vertical_win?).to be false
        end
      end
    end

    describe ".horizontal_win?" do
      context "when there is a horizontal winner" do
        it "returns the winner" do
          @board.set_horizontal_win("O")
          expect(@board.horizontal_win?).to eq("O")
        end
      end

      context "when there is no winner" do
        it "returns false" do
          @board.clear
          expect(@board.horizontal_win?).to be false
        end
      end
    end

    describe ".diagonal_win?" do
      context "when there is a diagonal winner from top-left to bottom-right" do
        it "returns the winner" do
          @board.set_diagonal_win_top_left("X")
          expect(@board.diagonal_win?).to eq("X")
        end
      end

      context "when there is a diagonal winner from top-right to bottom left" do
        it "returns the winner" do
          @board.set_diagonal_win_top_right("O")
          expect(@board.diagonal_win?).to eq("O")
        end
      end

      context "when there is no vertical winner" do
        it "returns false" do
          @board.clear
          expect(@board.vertical_win?).to be false
        end
      end
    end

  end

  describe ".victory" do
    it "prints the winner and returns true" do
      @board.set_vertical_win("X")
      capture_stdout { expect(@board.victory(@board.vertical_win?)).to be true }
    end
  end

  # This method is just a wrapper that checks all win conditions
  describe ".win" do
    context "when there is a vertical winner" do
      it "it prints and returns the winner" do
        @board.set_vertical_win("O")
        capture_stdout { expect(@board.win).to eq("O") }
      end
    end

    context "when there is a horizontal winner" do
      it "it prints and returns the winner" do
        @board.set_horizontal_win("X")
        capture_stdout { expect(@board.win).to eq("X") }
      end
    end

    context "when there is a diagonal winner from top-right to bottom-left" do
      it "it prints and returns the winner" do
        @board.set_diagonal_win_top_right("O")
        capture_stdout { expect(@board.win).to eq("O") }
      end
    end

    context "when there is a diagonal winner from top-left to bottom-right" do
      it "it prints and returns the winner" do
        @board.set_diagonal_win_top_left("X")
        capture_stdout { expect(@board.win).to eq("X") }
      end
    end

    context "when there is no winner" do
      it "returns false" do
        @board.fill("tie")
        capture_stdout { expect(@board.win).to be false }
      end
    end
  end

  describe "board_empty?" do
    context "when the board is empty" do
      it "returns true" do
        @board.clear
        expect(@board.board_empty?).to be true
      end
    end

    context "when the board is not empty" do
      it "returns false" do
        @board.confirm(@move)
        expect(@board.board_empty?).to be false
      end
    end
  end

end
