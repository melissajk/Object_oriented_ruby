
class Card
  attr_reader :face
  SUIT = ['H', 'C', 'S', 'D']
  FACE = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  
  def initialize(suit, face)
    @suit = suit
    @face = face
  end
  
  def to_s
    "The #{@face} of #{@suit}"
  end
  
  def ace?
    @face == 'A'
  end
  
  def face_card?
    ['J','K', 'Q'].include?(@face)
  end
end

class Deck
  
  def initialize
    @cards = []
    Card::SUIT.product(Card::FACE).each do |card|
      @cards << Card.new(card.first, card.last)
      shuffle!
    end
    
    def deal_card
      @cards.pop
    end
  end
  
  def shuffle!
    @cards.shuffle!
  end
end

module Hand
  
  def show_hand
    puts "---- Player's hand ----"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "Total: #{total}"
    puts ""
  end
  
  def total
    total = 0
    cards.each do |card|
      if card.ace?
        total += 11
      elsif card.face_card?
        total += 10
      else
        total += card.face.to_i
      end
    end
    
    cards.select(&:ace?).count.times do
      break if total <= 21
      total -= 10
    end
    total
  end
  
  def add_card!(new_card)
    @cards << new_card
  end
  
  def busted?
    total > 21
  end
end

class Deck
  def initialize
    @cards = []
    Card::SUIT.product(Card::FACE).each do |card|
      @cards << Card.new(card.first, card.last)
      shuffle!
    end
    
    def deal_card
      @cards.pop
    end
  end
  
  def shuffle!
    @cards.shuffle!
  end
end

class Player
  include Hand
  attr_accessor :cards
  
  def initialize
    @cards = []
  end
  
  def choose_action
    puts "Do you want to (h)it or (s)tay?"
    choice = nil
    loop do
      choice = gets.chomp.downcase
      break if ['h', 's'].include?(choice)
      puts "Please enter a valid response."
    end
    choice
  end
end

class Dealer
  include Hand
  attr_accessor :cards
  def initialize
    @cards = []
  end
  
  def show_initial_hand
    puts "---- Dealer's hand ----"
    puts "=> #{cards.first}"
    puts "---- ?? ----"
    puts ""
  end
end

class TwentyOne
  attr_accessor :player, :dealer, :deck
  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end
  
  def display_welcome_message
    puts "Welcome to Twenty-One!"
  end
  
  def display_goodbye_message
    puts "Thank you for playing Twenty-One. Goodbye!"
  end
  
  def deal_cards
    2.times do
      player.add_card!(deck.deal_card)
      dealer.add_card!(deck.deal_card)
    end
  end

  def player_turn
    loop do
      choice = player.choose_action
      
      if choice == 's'
        puts "Player stays!"
        break
      else
        puts "Player hits!"
        player.add_card!(deck.deal_card)
        player.show_hand
        break if player.busted?
      end
    end
  end
    
  def dealer_turn
    loop do
      if dealer.total >= 17
        puts "Dealer stays!"
        break
      else
        puts "Dealer hits!"
        dealer.add_card!(deck.deal_card)
        break if dealer.busted?
      end
    end
  end
  
  def someone_busted
    if player.busted?
      puts "You bust! Dealer wins!"
    elsif dealer.busted?
      puts "Dealer busts! Player wins!"
    end
  end
  
  def show_results
    if player.total > dealer.total
      puts "Player wins!"
    elsif dealer.total > player.total
      puts "Dealer wins!"
    else
      puts "It's a tie!"
    end
  end
  
  def show_initial_hand
    player.show_hand
    dealer.show_initial_hand
  end
  
  def show_cards
    player.show_hand
    dealer.show_hand
  end
  
  def play_again?
    answer = ""
    loop do
      puts "Do you want to play again (y or n)?"
      answer = gets.chomp.downcase
      break if ["y", "n"].include?(answer)
      puts "Please enter a valid response."
    end
    answer == 'y'
  end
  
  def reset
    @deck = Deck.new
    player.cards = []
    dealer.cards = []
  end

  def play
    display_welcome_message
    loop do
      deal_cards
      show_initial_hand
      
      player_turn
      if player.busted?
        someone_busted
        if play_again?
          reset
          next
        else
          break
        end
      end
      
      dealer_turn
      if dealer.busted?
        someone_busted
        if play_again?
          reset
          next
        else
          break
        end
      end
      
      show_cards
      show_results
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

end

game = TwentyOne.new
game.play


