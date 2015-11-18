# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # 1st Column
  [1,4,7],  # 2nd Column
  [2,5,8],  # 3rd Column
  [2,4,6],  # Cross 1
  [0,4,8]  # Cross 2
]

def move(board, position, player)
  board[position-1]=player
end

def display_board(board)
  count=1
  board.each do |position|
    print " #{position} "
    if (count == 3) or (count == 6 )  
      print "\n-----------\n"
    elsif count == 9
      print "\n"
    else
      print "|"
    end
    count = count + 1
  end
end

def won?(board)
WIN_COMBINATIONS.each do |win_combo|
  if board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X"
    return win_combo
  elsif board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
      return win_combo
  end
end
return false
end

def full?(board)
  if board[0..8].all? {|position| (position == "X") or (position == "O")} 
    return true
  else
    return false
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  elsif won?(board) == false && full?(board) == false
    return false
  else won?(board) == true
    return false
  end
end

def over?(board)
  if won?(board) 
    return true
  elsif draw?(board) 
    return true
  elsif full?(board)
    return true
  else 
    false
  end
end

def valid_move?(board,position)
  position = position.to_i - 1
  if (position.to_i >= 0) && (position.to_i < 9)
    if board[position.to_i] == " "
      return true
    end
  end
  return false
end

def turn(board)
  puts "Please input 1-9"
  position = gets.to_i
  while valid_move?(board,position) == false
    position = gets.to_i
  end
  if turn_count(board).even?
    player = "X"
  else
    player = "O"
  end
  if valid_move?(board, position)
    move(board, position, player)
  end  
end

def turn_count(board)
  filled_count = 0 
  board.each do |position|
    if (position == "X" or position == "O")
      filled_count = filled_count + 1
    end
  end
  turns = filled_count
return turns 
end

def current_player(board)
  if turn_count(board).even?
    return "O"
  else
    return "X"
  end
end

def winner(board)
WIN_COMBINATIONS.each do |win_combo|
  win_index_1 = win_combo[0]
  win_index_2 = win_combo[1]
  win_index_3 = win_combo[2]
  if board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X"
    return "X" 
  elsif board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
    return "O" 
  end
end
return nil
end

def play(board)
until over?(board)
 turn(board)
end

if won?(board)
  puts "Congratulations #{winner(board)}!"
end

if draw?(board)
  puts "Cats Game!"
end
end
