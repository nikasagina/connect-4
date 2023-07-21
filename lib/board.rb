class Board
  attr_accessor :grid
  RED = 1
  YELLOW = 2
  ROW_NUM = 6
  COL_NUM = 7

  def initialize()
    @grid = Array.new(ROW_NUM) { Array.new(COL_NUM, 0) }
  end

  def place(col, color)
    return false if col < 0 or col > COL_NUM
    row = lowest_row(col)
    return false if row == ROW_NUM
    @grid[row][col] = color
    row
  end

  def lowest_row(col)
    row = 0
    row += 1 while row < ROW_NUM && @grid[row][col] != 0
    row
  end

  def winning_place?(row, col, color)
    horizontal_win?(row, col, color) or vertical_win?(row, col, color) or diagonal_win?(row, col, color)
  end

  def horizontal_win?(row, col, color)
    consecutive_count_pos = 1
    consecutive_count_neg = 1
    begin
    consecutive_count_pos += 1 while @grid[row][col + consecutive_count_pos] == color
    rescue
    end
    begin
    consecutive_count_neg += 1 while @grid[row][col - consecutive_count_neg] == color
    rescue
    end

    consecutive_count_pos + consecutive_count_neg > 4
  end

  def vertical_win?(row, col, color)
    consecutive_count_pos = 1
    consecutive_count_neg = 1

    begin
    consecutive_count_pos += 1 while @grid[row + consecutive_count_pos][col] == color
    rescue
    end
    begin
    consecutive_count_neg += 1 while @grid[row - consecutive_count_neg][col] == color
    rescue
    end

    consecutive_count_pos + consecutive_count_neg > 4
  end

  def diagonal_win?(row, col, color)
    # check main diagonal
    consecutive_count_pos = 1
    consecutive_count_neg = 1

    begin
    consecutive_count_pos += 1 while @grid[row + consecutive_count_pos][col + consecutive_count_pos] == color
    rescue
    end
    begin
    consecutive_count_neg += 1 while @grid[row - consecutive_count_neg][col - consecutive_count_neg] == color
    rescue
    end

    return true if consecutive_count_pos + consecutive_count_neg > 4

    # check other diagonal
    consecutive_count_pos = 1
    consecutive_count_neg = 1

    begin
    consecutive_count_pos += 1 while @grid[row + consecutive_count_pos][col - consecutive_count_pos] == color
    rescue
    end
    begin
    consecutive_count_neg += 1 while @grid[row - consecutive_count_neg][col + consecutive_count_neg] == color
    rescue
    end

    consecutive_count_pos + consecutive_count_neg > 4
  end

  def print_board
    ROW_NUM.times do |row|
      COL_NUM.times do |col|
        if @grid[ROW_NUM - 1 - row][col] == Board::RED
          print "🟡"
        elsif @grid[ROW_NUM - 1 - row][col] == Board::YELLOW
          print "🔴"
        else
          print "  "
        end
      end
      print "\n"
    end
    COL_NUM.times do |col|
      print " #{col}"
    end
    print "\n"
  end

  def no_more_space?
    ROW_NUM.times do |row|
      COL_NUM.times do |col|
        return false if @grid[row][col] == 0
      end
    end
    true
  end
end
