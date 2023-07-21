require './lib/board.rb'  #=> add this

describe Board do
  describe "#horizontal_win?" do
    it "return false on empty board" do
      board = Board.new
      6.times do |row|
        7.times do |col|
          expect(board.horizontal_win?(row, col, Board::RED)).to eql(false)
          expect(board.horizontal_win?(row, col, Board::YELLOW)).to eql(false)
        end
      end
    end

    it "return true on full color row" do
      board = Board.new
      3.times do |i|
        board.grid[0][i] = Board::RED
        board.grid[0][4 + i] = Board::RED
      end

      # row:  1 1 1 0 1 1 1
      expect(board.horizontal_win?(0, 3, Board::RED)).to eql(true)
    end


    it "return true on 4 consecutive" do
      board = Board.new
      board.grid[0][1] = Board::RED
      board.grid[0][2] = Board::RED
      board.grid[0][4] = Board::RED
      # row:  0 1 1 0 1 0 0
      expect(board.horizontal_win?(0, 3, Board::RED)).to eql(true)
    end

    it "return true on edge 4 consecutive" do
      board = Board.new
      board.grid[0][1] = Board::RED
      board.grid[0][2] = Board::RED
      board.grid[0][3] = Board::RED
      # row:  X 1 1 1 0 0 0
      expect(board.horizontal_win?(0, 0, Board::RED)).to eql(true)
    end


    it "return false on different color" do
      board = Board.new
      board.grid[0][0] = Board::RED
      board.grid[0][1] = Board::RED
      board.grid[0][2] = Board::YELLOW
      board.grid[0][4] = Board::RED
      board.grid[0][5] = Board::RED
      board.grid[0][6] = Board::YELLOW
      # row:  1 1 2 0 1 1 2
      expect(board.horizontal_win?(0, 3, Board::RED)).to eql(false)
    end
  end

  describe "#vertical_win?" do
    it "return false on empty board" do
      board = Board.new
      6.times do |row|
        7.times do |col|
          expect(board.vertical_win?(row, col, Board::RED)).to eql(false)
          expect(board.vertical_win?(row, col, Board::YELLOW)).to eql(false)
        end
      end
    end

    it "return true on color tower" do
      board = Board.new
      board.grid[0][0] = Board::RED
      board.grid[1][0] = Board::RED
      board.grid[2][0] = Board::RED

      expect(board.vertical_win?(3, 0, Board::RED)).to eql(true)
    end


    it "return false on different color tower" do
      board = Board.new
      board.grid[0][0] = Board::RED
      board.grid[1][0] = Board::RED
      board.grid[2][0] = Board::RED

      expect(board.vertical_win?(3, 0, Board::YELLOW)).to eql(false)
    end
  end


  describe "#diagonal_win?" do
    it "return false on empty board" do
      board = Board.new
      6.times do |row|
        7.times do |col|
          expect(board.diagonal_win?(row, col, Board::RED)).to eql(false)
          expect(board.diagonal_win?(row, col, Board::YELLOW)).to eql(false)
        end
      end
    end

    it "return true on full diagonal" do
      board = Board.new
      board.grid[1][1] = Board::RED
      board.grid[2][2] = Board::RED
      board.grid[3][3] = Board::RED

      # 0 0 0 1
      # 0 0 1 0
      # 0 1 0 0
      # X 0 0 0 ...
      expect(board.diagonal_win?(0, 0, Board::RED)).to eql(true)
    end

    it "return true on full diagonal middle" do
      board = Board.new
      board.grid[0][0] = Board::RED
      board.grid[1][1] = Board::RED
      board.grid[3][3] = Board::RED

      # 0 0 0 1
      # 0 0 X 0
      # 0 1 0 0
      # 1 0 0 0 ...
      expect(board.diagonal_win?(2, 2, Board::RED)).to eql(true)
    end


    it "return true on full diagonal other side" do
      board = Board.new
      board.grid[1][5] = Board::RED
      board.grid[2][4] = Board::RED
      board.grid[3][3] = Board::RED

      # 0 0 0 1 0 0 0
      # 0 0 0 0 1 0 0
      # 0 0 0 0 0 1 0
      # 0 0 0 0 0 0 X
      expect(board.diagonal_win?(0, 6, Board::RED)).to eql(true)
    end


    it "return true on full diagonal other side middle" do
      board = Board.new
      board.grid[0][6] = Board::RED
      board.grid[1][5] = Board::RED
      board.grid[3][3] = Board::RED

      # 0 0 0 1 0 0 0
      # 0 0 0 0 X 0 0
      # 0 0 0 0 0 1 0
      # 0 0 0 0 0 0 1
      expect(board.diagonal_win?(2, 4, Board::RED)).to eql(true)
    end

    it "return false on different color diagonal" do
      board = Board.new
      board.grid[0][0] = Board::RED
      board.grid[1][1] = Board::RED
      board.grid[3][3] = Board::RED

      # 0 0 0 2
      # 0 0 X 0
      # 0 2 0 0
      # 2 0 0 0 ...
      expect(board.diagonal_win?(2, 2, Board::YELLOW)).to eql(false)
    end

    it "return true on different color diagonal but also same color diagonal" do
      board = Board.new
      board.grid[0][0] = Board::RED
      board.grid[1][1] = Board::RED
      board.grid[3][3] = Board::RED
      board.grid[0][4] = Board::YELLOW
      board.grid[1][3] = Board::YELLOW
      board.grid[3][1] = Board::YELLOW

      # 0 1 0 2
      # 0 0 X 0
      # 0 2 0 1 ...
      # 2 0 0 0 1 ...
      expect(board.diagonal_win?(2, 2, Board::YELLOW)).to eql(true)
    end
  end


  describe "#place" do
    it "returns true & place at the bottom on empty" do
      board = Board.new

      expect(board.place(0, Board::RED)).to eql(true)
      expect(board.grid[0][0]).to eql(Board::RED)
      expect(board.place(5, Board::RED)).to eql(true)
      expect(board.grid[0][5]).to eql(Board::RED)
    end

    it "returns true & place on a color" do
      board = Board.new
      board.grid[0][0] = Board::RED
      expect(board.place(0, Board::RED)).to eql(true)
      expect(board.grid[1][0]).to eql(Board::RED)
      board.grid[0][5] = Board::RED
      expect(board.place(5, Board::YELLOW)).to eql(true)
      expect(board.grid[1][5]).to eql(Board::YELLOW)
    end

    it "returns true & place on top of a row" do
      board = Board.new
      board.grid[0][0] = Board::RED
      board.grid[1][0] = Board::RED
      board.grid[2][0] = Board::RED
      board.grid[3][0] = Board::RED
      board.grid[4][0] = Board::RED
      expect(board.place(0, Board::RED)).to eql(true)
      expect(board.grid[5][0]).to eql(Board::RED)
    end

    it "returns false when no more space on a column" do
      board = Board.new
      board.grid[0][0] = Board::RED
      board.grid[1][0] = Board::RED
      board.grid[2][0] = Board::RED
      board.grid[3][0] = Board::RED
      board.grid[4][0] = Board::RED
      board.grid[5][0] = Board::RED
      expect(board.place(0, Board::RED)).to eql(false)
    end
  end
end
