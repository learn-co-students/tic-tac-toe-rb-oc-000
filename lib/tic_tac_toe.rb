def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end 

def valid_move?(board, posit)
  
  positInt = posit.to_i
  positInt = positInt -1 
  if (board[positInt] != "X" && board[positInt] != "O") && (positInt>=0 && positInt < 9)
    true 
  else 
    false 
  end
end 


def move (board, posit, char="X")
  
  posit = posit.to_i
  posit = posit - 1
  board[posit] = char ; 

end 

def turn(board)
  puts "Please enter 1-9:"
  choice = gets.strip 
  if valid_move?(board, choice)
    move(board, choice  , current_player(board))
  else 
    while valid_move?(board, gets.strip) == false 
     puts "Please enter 1-9:"
     choice = gets.strip 
   end 
  
  end 
board = board 
display_board(board)
end 

def turn_count (board)
   count = 0
   board.each do |input| 
     if input == "X"|| input == "O" 
         count+=1
     end 
   end  
 
return count 
end 


def current_player(board)
  
   turns = turn_count(board)
    turns%2 == 0 ? "X" : "O" 
  

end 

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5,],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]

]

def won?(board)
  answer = false 
    WIN_COMBINATIONS.each do |arr|

        posit1 = arr[0]
        posit2 = arr[1]
        posit3 = arr[2]

       if board[posit1] == "X" && board[posit2] == "X" && board[posit3] == "X"
         answer = [posit1,posit2,posit3]

       elsif board[posit1] == "O" && board[posit2] == "O" && board[posit3] == "O"
          answer = [posit1,posit2,posit3]
        end 
      end 

      answer 
    end 

def full?(board)

  board.all?{|x|x=="X"||x=="O"}

end

def draw?(board)
  if won?(board)==false && full?(board)== true 
    true 
  else 
    false
end 

end 

def over?(board)

  if won?(board) != false || draw?(board) == true 
    true 
  else 
    false 
  end 

end 

def winner(board)
  if won?(board) != false 
    win = won?(board)
    board[win[0]]
  else 
    nil 
  end 
end 

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end



def play(board)

until over?(board)
    
    
    current_player(board)
    turn(board)
    
end
  
  if won?(board) != false 
    puts "Congratulations #{winner(board)}!"

  elsif draw?(board) == true
    puts "Cats Game!"


end 


end 








