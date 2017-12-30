module Displayable
  SPACER = ' | '
  DEFAULT_LINE_LENGTH = 36

  def clear_screen
    system('clear') || system('cls')
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def list_choices(choices)
    list = choices.map { |abbrev, move| "(#{abbrev})#{move}" }
    final = " or #{list.pop}"
    list.join(", ") + final
  end

  def request_choice(choices)
    prompt("Please choose #{list_choices(choices)}:")
  end

  def figure_extra_chars(name)
    return 0 if name.size < 10
    name.size - 10
  end

  def figure_line_length(name)
    return DEFAULT_LINE_LENGTH if figure_extra_chars(name).zero?
    DEFAULT_LINE_LENGTH + figure_extra_chars(name)
  end

  def star_line(line_length)
    '*' * line_length
  end

  def banner_line(line_length)
    '-' * line_length
  end
end

class Move
  attr_accessor :value
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  ITS_A_WIN = { 'rock' => ['scissors', 'lizard'],
                'paper' => ['rock', 'spock'],
                'scissors' => ['lizard', 'paper'],
                'lizard' => ['spock', 'paper'],
                'spock' => ['rock', 'scissors'] }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    ITS_A_WIN[value].include?(other_move.value)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score
  def initialize
    reset_score!
  end

  def reset_score!
    self.score = 0
  end

  def move_value
    move.value
  end
end

class Human < Player
  include Displayable
  MOVE_CHOICES = { 'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors',
                   'l' => 'lizard', 'sp' => 'spock' }

  def initialize
    super
    set_name
  end

  def set_name
    n = ''
    loop do
      prompt("What's your name?")
      n = gets.chomp.strip.squeeze(' ')
      break unless n.empty?
      prompt("Sorry, must enter a value.")
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      request_choice(MOVE_CHOICES)
      choice = gets.chomp.downcase
      choice = MOVE_CHOICES.fetch(choice, choice)
      break if MOVE_CHOICES.values.include?(choice)
      prompt("Sorry, invalid choice.")
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def initialize(history)
    super()
    @history = history
    set_available_moves
  end

  def choose
    self.move = if uses_strategy? && enough_rounds?
                  Move.new(favored_moves.sample)
                else
                  Move.new(available_moves.sample)
                end
  end

  def evaluate_losses(human_name)
    lost_moves = history_of_losses(human_name).map(&:computer_move)

    losses_per_move = create_loss_table(lost_moves)

    figure_loss_ratio(losses_per_move) if uses_strategy?
  end

  private

  attr_accessor :available_moves

  def set_available_moves
    self.available_moves = Move::VALUES
  end

  def uses_strategy?
    true
  end

  def enough_rounds?
    @history.history_list.size >= 6
  end

  def history_of_losses(human_name)
    lost_rounds = @history.history_list.select do |history|
      history.winner == human_name
    end
    lost_rounds
  end

  def create_loss_table(lost_moves)
    losses_per_move = available_moves.map do |move|
      lost_moves.count(move)
    end
    available_moves.zip(losses_per_move).to_h
  end

  def computer_move_history
    @history.history_list.map(&:computer_move)
  end

  def move_occurence_table
    move_occurences = available_moves.map do |move|
      computer_move_history.count(move)
    end
    available_moves.zip(move_occurences).to_h
  end
  
  def figure_loss_ratio(losses_per_move)
    loss_ratio = {}

    move_occurence_table.each_pair do |move, times_used|
      loss_ratio[move] = times_used.zero? ? 0.0 : 
                         (losses_per_move[move] / times_used.to_f)
      end
    reorder_moves!(loss_ratio)
  end

  def reorder_moves!(loss_ratio)
    sorted_loss_ratio = loss_ratio.to_a.sort_by(&:last)

    self.available_moves = sorted_loss_ratio.to_h.keys
  end

  def favored_moves
    available_moves.take(2)
  end
end

class Twiki < Computer # Old school!  rock, paper, scissors, only!
  def initialize(history)
    super(history)
    @name = 'Twiki'
  end

  private

  attr_reader :available_moves

  def uses_strategy?
    false
  end

  def set_available_moves
    self.available_moves = ['rock', 'paper', 'scissors']
  end
end

class Tars < Computer # Uses move history to play next move.
  def initialize(history)
    super(history)
    @name = 'Tars'
  end
end

class Ziggy < Computer # She's a big Spock fan!
  def initialize(history)
    super(history)
    @name = 'Ziggy'
  end

  private

  attr_reader :available_moves

  def set_available_moves
    self.available_moves = Move::VALUES + ['spock'] * 2
  end

  def favored_moves
    available_moves.take(2) + ['spock'] * 2
  end
end

class Hal < Computer # Rock only!
  def initialize(history)
    super(history)
    @name = 'Hal'
  end

  private

  attr_reader :available_moves

  def uses_strategy?
    false
  end

  def set_available_moves
    self.available_moves = ['rock']
  end
end

class Number5 < Computer # Lizards are alive like Johnny 5!
  def initialize(history)
    super(history)
    @name = 'Number 5'
  end

  private

  attr_reader :available_moves

  def uses_strategy?
    false
  end

  def set_available_moves
    self.available_moves = ['paper', 'scissors'] + ['lizard'] * 3
  end
end

class History
  attr_accessor :computer_move, :human_move, :winner
  def initialize(human_move, computer_move, winner)
    @human_move = human_move
    @computer_move = computer_move
    @winner = winner
  end
end

class HistoryList
  include Displayable
  attr_accessor :history_list
  def initialize
    @history_list = []
  end

  def append(human_move, computer_move, winner)
    @history_list << History.new(human_move, computer_move, winner)
  end

  def show_all
    @history_list.each do |history|
      puts history.human_move.ljust(9) + SPACER +
           history.computer_move.ljust(9) + SPACER +
           history.winner
    end
  end
end

class Round
  include Displayable
  attr_accessor :human, :computer, :history
  def initialize(human, computer, history)
    @human = human
    @computer = computer
    @history = history
  end

  def display_moves
    prompt("#{human.name} chose #{human.move}.")
    prompt("#{computer.name} chose #{computer.move}.")
  end

  def round_winner
    return human if human.move > computer.move
    return computer if computer.move > human.move
    nil
  end

  def display_winner
    if round_winner
      prompt("#{round_winner.name} wins!")
    else
      prompt("It's a tie! No points this round.")
    end
  end

  def result
    return round_winner.name if round_winner
    'tie'
  end

  def play
    human.choose
    computer.choose
    display_moves
    display_winner
    history.append(human.move_value, computer.move_value, result)
    computer.evaluate_losses(human.name)
  end
end

class RPSGame
  GOAL = 5
  include Displayable
  attr_accessor :human, :computer, :history

  def initialize
    @history = HistoryList.new
    @human = Human.new
    @computer = [Twiki, Hal, Tars, Number5, Ziggy].sample.new(@history)
  end

  def display_welcome_message
    prompt("Welcome to Rock, Paper, Scissors, Lizard, Spock!")
  end

  def display_goodbye_message
    prompt("Thanks for playing Rock, Paper, Scissors, Lizard, Spock.  Goodbye!")
  end

  def add_to_winner_score(winner)
    winner&.score += 1
  end

  def win_the_game?
    human.score == GOAL || computer.score == GOAL
  end

  def display_score
    extra_chars = figure_extra_chars(human.name)
    line_length = figure_line_length(human.name)

    display_score_banner(line_length)

    show_human_score(line_length, extra_chars)

    show_computer_score(line_length, extra_chars)

    return display_game_winner if win_the_game?

    prompt("First Player to #{GOAL} points wins!")
  end

  def display_score_banner(line_length)
    puts "\n" + star_line(line_length)

    if win_the_game?
      puts "Final score".center(line_length)
    else
      puts "Current Score".center(line_length)
    end

    puts star_line(line_length)
  end

  def show_human_score(line_length, extra_chars)
    puts human.name.ljust(15 + extra_chars) + SPACER +
         human.score.to_s.center(15)
    puts banner_line(line_length)
  end

  def show_computer_score(line_length, extra_chars)
    puts computer.name.ljust(15 + extra_chars) + SPACER +
         computer.score.to_s.center(15)
    puts banner_line(line_length)
  end

  def display_game_winner
    if human.score > computer.score
      puts "#{human.name} wins the game!"
    else
      puts "#{computer.name} wins the game!"
    end
  end

  def play_again?
    answer = nil
    loop do
      prompt("Would you like to play again (y/n)?")
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      prompt("Sorry, must be y or n.")
    end
    answer.downcase == 'y'
  end

  def display_history
    line_length = figure_line_length(human.name)

    display_history_banner(line_length)

    puts "Human".ljust(9) + SPACER +
         "Computer".ljust(9) + SPACER +
         "Winner".ljust(9)
    puts banner_line(line_length)

    history.show_all
  end

  def display_history_banner(line_length)
    puts "\n" + banner_line(line_length)
    puts "Player Move History".center(35)
    puts banner_line(line_length)
  end

  def play
    display_welcome_message
    loop do
      round = Round.new(human, computer, history)
      round.play
      add_to_winner_score(round.round_winner)
      display_score
      break if win_the_game?
      break unless play_again?
      clear_screen
    end
    display_goodbye_message
    display_history
  end
end

RPSGame.new.play
