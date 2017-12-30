class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
  
  def play
    "Let's play Bingo!"
  end
end

# What would happen if we added a #play method to the Bingo Class?  

# The #play method in the Bingo class would override the method in the Game 
# class

game = Bingo.new
puts game.play # Let's play Bingo!

