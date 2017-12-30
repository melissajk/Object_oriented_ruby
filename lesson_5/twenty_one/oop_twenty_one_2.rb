
class Card
  SUIT = ['H', 'C', 'S', 'D']
  FACE = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  
  def initialize(suit, face)
    @suit = suit
    @face = face
  end
  
  def to_s
    "The #{face} of #{suit}"
  end
  
  def suit
    case @suit
    when 'H' then "Hearts"
    when 'S' then "Spades"
    when 'C' then "Clubs"
    when 'D' then "Diamonds"
    end
  end
  
  def face
    case @face
    when 'A' then 'Ace'
    when 'K' then 'King'
    when 'Q' then 'Queen'
    when 'J' then 'Jack'
    else @face
    end
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
    puts "---- #{name}'s hand ----"
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

class Participant
  include Hand
  attr_accessor :cards, :name
  
  def initialize
    @cards = []
    set_name
  end
end

class Player < Participant
  
  def set_name
    name = ''
    loop do
      puts "What is your name?"
      name = gets.chomp.strip
      break unless name.empty?
      puts "Please enter you name."
    end
    self.name = name
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

class Dealer < Participant
  ROBOTS = ['Twiki', 'Hal', 'Tars', 'Number 5', 'C3PO']
  
  def set_name
    self.name = ROBOTS.sample
  end
  
  def show_initial_hand
    puts "---- #{name}'s hand ----"
    puts "=> #{cards.first}"
    puts "---- ?? ----"
    puts ""
  end
end

class TwentyOne
  attr_accessor :player, :dealer, :deck
  def initialize
    display_welcome_message
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
    puts "#{player.name}'s turn... "
    loop do
      
      choice = player.choose_action
      
      if choice == 's'
        puts "#{player.name} stays!"
        break
      else
        puts "#{player.name} hits!"
        player.add_card!(deck.deal_card)
        player.show_hand
        break if player.busted?
      end
    end
  end
    
  def dealer_turn
    puts "#{dealer.name}'s turn... "
    loop do
      if dealer.total >= 17
        puts "#{dealer.name} stays!"
        break
      else
        puts "#{dealer.name} hits!"
        dealer.add_card!(deck.deal_card)
        break if dealer.busted?
      end
    end
  end
  
  def clear_screen
    system('clear') || system('cls')
  end
  
  def someone_busted
    if player.busted?
      puts "#{player.name} busts! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "#{dealer.name} busts! #{player.name} wins!"
    end
  end
  
  def show_results
    if player.total > dealer.total
      puts "#{player.name} wins!"
    elsif dealer.total > player.total
      puts "#{dealer.name} wins!"
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
    clear_screen
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


