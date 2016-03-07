# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]

def won?(board)
    if empty?(board)
       return false
    else
      WIN_COMBINATIONS.detect {|combo|
      board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && board[combo[2]] != " "
      }
    end
end

def empty?(board)
    board.none?{|i| i == "X" || i == "O"}
end

def full?(board)
  board.none?{|i| i == " "}
end

def draw? (board)
  if ! won?(board) && full?(board)
    return true
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, player = "X")
  board[location.to_i-1] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  player = current_player(board)
  if valid_move?(board, input)
    move(board, input, player)
    if won?(board)
        puts "Congratulations! #{winner(board)} has won!"
        exit
      elsif
        draw?(board)
        puts "The game is a draw! Try harder next time."
        exit
      end
    else
      turn(board)
  end
  display_board(board)
end

def play(board)
  turns = 0
  until turns == 9
    turn(board)
    turns += 1
  end
end

def turn_count(board)
  board.count{|i| i == "X" || i == "O"}
end

def current_player (board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end
