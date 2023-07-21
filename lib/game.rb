require_relative "board.rb"

board = Board.new
player_turn = 1

while true do
  board.print_board

  if board.no_more_space?
    puts "The game is a tie"
    break
  end
  print "Player #{player_turn}'s turn: "
  col = gets.chomp!.to_i

  row = board.place(col, player_turn)

  unless row
    puts "Failed placing, please place the color in available column "
    next
  end

  if board.winning_place?(row, col, player_turn)
    puts "Congrats, you win"
    board.print_board
    break
  elsif player_turn == 1
    player_turn = 2
  else
    player_turn = 1
  end
end
