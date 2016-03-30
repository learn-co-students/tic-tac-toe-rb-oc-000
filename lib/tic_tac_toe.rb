 WIN_COMBINATIONS =[
    [0, 1, 2], # top row
    [3, 4, 5], # middle row
    [6, 7, 8], # bottom row
    [0, 3, 6], # left column
    [1, 4, 7], # middle column
    [2, 5, 8], # right column
    [0, 4, 8], # diagonal 1
    [2, 4, 6], # diagonal 2
    ]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
    else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "X" || token == "O"
    counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
    else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
  elsif
    position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination
  else
    false
  end
  end
  false
end

def full?(board)
  if board.all? {|item| item == "X" || item == "O"}
    true
  else
    false
  end
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board)
    true
  elsif
    draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    winning_token_index = won?(board)[0]
    winning_token = board[winning_token_index]
    if winning_token == "X"
      return "X"
    else
      return "O"
    end
  else
    nil
  end
end

def play(board) #to test rspec spec/02_play_spec.rb
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end



