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
  
  def choose_action
    total >= 17 ? 's' : 'h'  # stay or hit
  end
end

class Round
  attr_accessor :player, :dealer, :deck
  
  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @deck = Deck.new
    @current_player = player
  end
  
  def deal_cards
    2.times do
      player.add_card!(deck.deal_card)
      dealer.add_card!(deck.deal_card)
    end
  end
  
  def play_hand(curr_player)
    puts "#{curr_player.name}'s turn... "
    loop do
      choice = curr_player == player ? player.choose_action :
                                       dealer.choose_action

      if choice == 's'
        puts "#{curr_player.name} stays!"
        break
      else
        puts "#{curr_player.name} hits!"
        curr_player.add_card!(deck.deal_card)
        player.show_hand if curr_player == player
        break if curr_player.busted?
      end
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

  def hand_winner
    return dealer if player.busted?
    return player if dealer.busted?
    
    if dealer.total > player.total
      dealer
    elsif player.total > dealer.total
      player
    else
      nil
    end
  end

  def play
    deal_cards
    show_initial_hand
    play_hand(player)
    return hand_winner if player.busted?
    play_hand(dealer)
    return hand_winner if dealer.busted?
    show_cards
  end
end

class TwentyOne
  attr_reader :player, :dealer, :round
  def initialize
    display_welcome_message
    @player = Player.new
    @dealer = Dealer.new
  end
  
  def display_welcome_message
    puts "Welcome to Twenty-One!"
  end
  
  def display_goodbye_message
    puts "Thank you for playing Twenty-One. Goodbye!"
  end

  def clear_screen
    system('clear') || system('cls')
  end
  
  def show_results(hand_winner)
    if hand_winner.nil?
      puts "It's a tie!"
    else
      puts "#{hand_winner.name} wins!"
    end
  end
  
  def someone_busted?
    player.busted? || dealer.busted?
  end

  def show_busted
    if player.busted?
      puts "#{player.name} busts!"
    elsif dealer.busted?
      puts "#{dealer.name} busts!"
    end
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
    player.cards = []
    dealer.cards = []
  end

  def play
    loop do
      clear_screen
      @round = Round.new(player, dealer)
      round.play
      show_busted if someone_busted?
      show_results(round.hand_winner)
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

end

game = TwentyOne.new
game.play


