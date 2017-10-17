
#This defines win combinations
WIN_COMBINATIONS = [
  [0, 1, 2],  #top row win
  [3, 4, 5],  #middle row win
  [6, 7, 8],  #bottom row win
  [0, 3, 6],  #left column win
  [1, 4, 7],  #middle column win
  [2, 5, 8],  #right column win
  [0, 4, 8], #top left to bottom right win
  [2, 4, 6], #bottom left to top right win
]

#This prints the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Defines a move
def move(board, position, player)
  board[position.to_i - 1] = player
end

puts "Turn 1: Where would you like to go? 1-9"
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

#Checks if position is already taken
def position_taken?(board, position)
  !(board[position] == "" || board[position] == " " || board[position] == nil)
end

#checks if move is valid
def valid_move?(board, position)
  position = (position.to_i - 1)

  if position.between?(0, 8) && !position_taken?(board, position)
    true
  else false
  end
end

#defines a turn. asks user for input and loops if invalid.
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip()
  valid = false
  while valid == false
    if valid_move?(board, position)
      move(board, position, current_player(board))
      valid = true
    else
      puts "Invalid Move. Please enter 1-9:"
      position = gets.strip()
    end
  end
end

#Counts the number of turns that have been played
def turn_count(board)
  turn_counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      turn_counter += 1
    end
  end
  turn_counter
end

#Uses the turn_count method to determine if it is "X" or "O" turn.
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

#--------begining of game status----------
#checks for win combinations and prints winning combo, or nil
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if (board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]] && board[combo[0]] != " " && board[combo[0]] != "" && !board[combo[0]].nil?)
      return combo
      break
    end
  end
  return false
end

#returns true if every element of the board is full
def full?(board)
  if !(won?(board))
    board.each do |e|
      if (e != "X" && e != "O")
        return false
      end
    end
  end
  return true
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winner = won?(board)
  if winner
    return board[winner[0]]
  else
    nil
  end
end
#-------end of game status-----------


#main application method responsible for game loop
def play(board)
  while !(over?(board))
    display_board(board)
    turn(board)
  end
    if won?(board) != false
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
end
