WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char = 'X')
  board[position.to_i - 1] = char
end

def valid_move?(board, position)
  return false if position.length > 1
  (position_taken?(board, position.to_i) || !(0...9).include?(position.to_i)) ? false : true
end

def position_taken?(board, position)
  board[position] == 'X' || board[position] == 'O' ? true : false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.reject { |position| position == ' ' }.count
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def won?(board)
  WIN_COMBINATIONS.select do |combo|
    combo.all? { |position| board[position] == 'X' } || combo.all? { |position| board[position] == 'O' }
  end.first
end

def full?(board)
  board.none? { |space| space == ' ' } ? true : false
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  end
end

def over?(board)
  won?(board) || draw?(board) ? true : false
end

def winner(board)
  won?(board) ? board[won?(board).first] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    if won?(board).is_a? Array
      winner = board[won?(board).first]
      puts "Congratulations #{winner}!"
    end
  elsif draw?(board)
    puts "Cats Game!"
  end
end
