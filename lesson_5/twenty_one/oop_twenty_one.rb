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
    ['J', 'K', 'Q'].include?(@face)
  end
end

class Deck
  def initialize
    @cards = []
    Card::SUIT.product(Card::FACE).each do |card|
      @cards << Card.new(card.first, card.last)
    end
    shuffle!
  end

  def deal_card
    @cards.pop
  end

  def shuffle!
    @cards.shuffle!
  end
end

module Hand
  ACE_VALUE = 11
  FACE_CARD_VALUE = 10

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
      total += 11 if card.ace?
      total += 10 if card.face_card?
      total += card.face.to_i
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
  HIT = 'h'
  STAY = 's'
  include Hand
  attr_accessor :cards, :name, :score

  def initialize
    @cards = []
    @score = 0
    set_name
  end

  def add_a_point
    @score += 1
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      puts "What is your name?"
      name = gets.chomp.strip
      break unless name.empty?
      puts "Please enter your name."
    end
    self.name = name
  end

  def choose_action
    puts "Do you want to (h)it or (s)tay?"
    choice = nil
    loop do
      choice = gets.chomp.downcase
      break if [HIT, STAY].include?(choice)
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
    total >= 17 ? STAY : HIT
  end
end

class Round
  attr_accessor :player, :dealer, :deck

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @deck = Deck.new
  end

  def deal_cards
    2.times do
      player.add_card!(deck.deal_card)
      dealer.add_card!(deck.deal_card)
    end
  end

  def play_hand(curr_player)
    player = curr_player.name

    puts "#{player}'s turn... "
    loop do
      sleep(1)
      if curr_player.choose_action == 's'
        puts "#{player} stays!"
        break
      else
        puts "#{player} hits!"
        curr_player.add_card!(deck.deal_card)
        player.show_hand if curr_player == player
        break if curr_player.busted?
      end
    end
    sleep(1)
  end

  def show_initial_hand
    player.show_hand
    dealer.show_initial_hand
  end

  def show_cards
    player.show_hand
    dealer.show_hand
  end

  def compare_cards
    if dealer.total > player.total
      dealer
    elsif player.total > dealer.total
      player
    end
  end

  def hand_winner
    return dealer if player.busted?
    return player if dealer.busted?
    compare_cards
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
  GOAL = 5
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

  def show_score
    puts "******** SCORE ****************"
    puts "#{player.name}: #{player.score}"
    puts "#{dealer.name}: #{dealer.score}"
    puts "First one to #{GOAL} wins!"
    puts ""
  end

  def show_final_score
    puts "******** FINAL SCORE **********"
    puts "#{player.name}: #{player.score}"
    puts "#{dealer.name}: #{dealer.score}"
    puts "#{game_winner} wins the game!"
    puts ""
  end

  def show_winner(hand_winner)
    if hand_winner.nil?
      puts "It's a tie! No points this round!"
    else
      puts "#{hand_winner.name} wins!"
    end
  end

  def game_winner
    player.score == GOAL ? player.name : dealer.name
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

  def keep_score
    round.hand_winner&.add_a_point
  end

  def someone_won?
    player.score == GOAL || dealer.score == GOAL
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

  def show_results
    show_busted if someone_busted?
    show_winner(round.hand_winner)
  end

  def play
    loop do
      clear_screen
      @round = Round.new(player, dealer)
      round.play
      keep_score
      show_results
      break if someone_won?
      show_score
      break unless play_again?
      reset
    end
    show_final_score
    display_goodbye_message
  end
end

game = TwentyOne.new
game.play
