# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,3,6], #Left col
  [1,4,7], #Middle col
  [2,5,8], #Right col
  [0,4,8], #Diag 1
  [2,4,6]  #Diag 2
  ]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  divider = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts divider
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts divider
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, input)
  if input.to_i().between?(1,9) && !(position_taken?(board, input.to_i()-1))
    true
  end
end
# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, position)
  if (board[position] == "X" || board[position] == "O")
    true
  else
    false
  end

end

def move(board,num,char = "X")
  board[(num.to_i) - 1] = char
  return board
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip()
  if valid_move?(board,input)
    move(board,input, current_player(board))
    display_board(board)
  else
    turn(board)
  end

end

def turn_count(board)
  turn = 0
  board.each do | move |
    if (move == "X" || move == "O")
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  #for each winning array, check to see if the values
  #on the board are all X's or all O's

  WIN_COMBINATIONS.each do |win| #
    if (win.all?{|i| board[i].eql? "X"} || win.all?{|i| board[i].eql? "O"})
      return win
    end
  end
  return false
end

def full?(board)
  #determine if all elements of the board
  #are not equal to " "
  board.all?{|i| !(i.eql? " ")}
end

def draw?(board)
  #check if board is full and no one has won
  full?(board) && !(won?(board))
end

def full?(board)
  #determine if all elements of the board
  #are not equal to " "
  board.all?{|i| !(i.eql? " ")}
end

def over?(board)
  #check if board is full and no one has won

  draw?(board) || won?(board)
end

def winner(board)
  #the winner is token at one of the winning indexes

  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  if !over?(board)
    turn(board)
    play(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end