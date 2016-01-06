WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board,position,player="X")
  board[position.to_i-1] = player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  move = (position.to_i)-1
  !position_taken?(board, move) && move >= 0 && move < board.length
end

def turn(board)
  position = gets.chomp
  if valid_move?(board,position)
    move(board,position,current_player(board))
  else
    puts "Invalid move."
    turn(board)
  end
end

def turn_count(board)
  board.select { |cell| ["X","O"].include?(cell) }.length
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    token = board[combo.first]
    if combo.all? { |index| board[index] == token } && ["O","X"].include?(token)
      return combo
    end
  end
  return false
end

def full?(board)
  board.all? { |cell| ["X","O"].include?(cell) }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  winning_combo = won?(board)
  winning_combo ? board[winning_combo.first] : nil
end

def play(board)
  while !over?(board)
    display_board(board)
    puts "Where would you like to move?"
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
