class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game  # This denotes that Game is a superclass, so now Bingo can now access its methods
  def rules_of_play
    #rules of play
  end
end

# What can we add to the Bingo class to access the #play method in the Game class?

game = Bingo.new
puts game.play # Start the game!


