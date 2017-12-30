module Constructable
  PIPE          = '|'.freeze
  GAP           = ' '.freeze
  DIV_LINE      = '-'.freeze
  CROSS_HAIRS   = '+'.freeze
  SQUARE_WIDTH  = 5

  def construct_grid_section(structure1, structure2)
    result = Array.new(3, SQUARE_WIDTH).map do |width|
      structure1 * width
    end
    puts result.join(structure2)
  end

  def empty_grid_section
    construct_grid_section(GAP, PIPE)
  end

  def grid_divider
    construct_grid_section(DIV_LINE, CROSS_HAIRS)
  end
end

module Displayable
  def clear_screen_and_display_board
    clear
    display_board
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def clear
    system('cls') || system('clear')
  end

  def joinor(arr, punc=', ', conj='or')
    case arr.size
    when 0 then ''
    when 1 then arr.first.to_s
    when 2 then arr.join(" #{conj} ")
    else
      final = ", #{conj} #{arr.pop}"
      arr.join(punc) + final
    end
  end

  def display_welcome_message(game_name)
    prompt("Welcome to #{game_name}!")
    puts ''
  end

  def display_goodbye_message(game_name)
    prompt("Thanks for playing #{game_name}! Goodbye!")
  end

  def display_play_again_message
    prompt("Let's play again!")
    puts ''
  end

  def display_game_winner(winner)
    puts ""
    puts "***** #{winner} wins the game! *****"
    puts ""
  end
end

module Bannerize
  LINE_LENGTH   = 36 # default values
  NAME_LENGTH   = 10
  SPACE_LENGTH  = 16
  STAR          = "*".freeze

  def extra_chars(name)
    @extra_chars = name.size <= NAME_LENGTH ? 0 : name.size - NAME_LENGTH
  end

  def figure_line_length(name)
    @line_length =
      extra_chars(name).zero? ? LINE_LENGTH : LINE_LENGTH + extra_chars(name)
  end

  def score_banner(title)
    puts "\n" + star_line
    puts title.center(@line_length)
    puts star_line
  end

  def show_score(name, score)
    puts name.ljust(SPACE_LENGTH + @extra_chars) + Constructable::PIPE +
         score.to_s.center(SPACE_LENGTH)
    puts banner_line
  end

  def star_line
    STAR * @line_length
  end

  def banner_line
    Constructable::DIV_LINE * @line_length
  end
end

class Board
  include Constructable
  CENTER_SQUARE = 5
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def center_square_available?
    @squares[CENTER_SQUARE].unmarked?
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def best_move_choice(marker, other_marker)
    return CENTER_SQUARE if center_square_available?

    find_best_square(marker) ||
      find_best_square(other_marker) ||
      unmarked_keys.sample
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def draw
    top_section
    middle_section
    lower_section
  end

  private

  def top_section
    empty_grid_section
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    empty_grid_section
    grid_divider
  end

  def middle_section
    empty_grid_section
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    empty_grid_section
    grid_divider
  end

  def lower_section
    empty_grid_section
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    empty_grid_section
  end

  def find_best_square(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(squares, marker) &&
         one_empty_square?(squares)
        return line.select { |num| @squares[num].unmarked? }.first
      end
    end
    nil
  end

  def one_empty_square?(squares)
    squares.select(&:unmarked?).size == 1
  end

  def two_identical_markers?(squares, marker)
    squares.collect(&:marker).count(marker) == 2
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " ".freeze

  attr_accessor :marker

  def initialize(marker= INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :score, :name

  def initialize
    reset_score
  end

  def reset_score
    @score = 0
  end

  def add_a_point!
    @score += 1
  end
end

class Human < Player
  include Displayable

  QUESTIONS = {
    marker:     "Do you want to be 'X' or 'O'? (x/o)",
    first_up:   "Who's up first: Player or Computer? (p/c)",
    play_again: "Would you like to play again? (y/n)"
  }

  def initialize
    super
    set_name
    set_marker
  end

  def human_moves(board)
    prompt("Choose a square between (#{joinor(board.unmarked_keys)}): ")
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      prompt("Sorry, that's not a valid choice.")
    end

    board[square] = marker
  end

  def request_choice(question, responses)
    choice = ''
    loop do
      prompt(QUESTIONS[question])
      choice = gets.chomp.downcase
      break if responses.include?(choice)
      prompt("Sorry, must be #{responses.first} or #{responses.last}.")
    end
    choice
  end

  private

  def set_marker
    responses = TTTGame::MARKERS.map(&:downcase)
    @marker = request_choice(:marker, responses).upcase
  end

  def set_name
    name = ''
    loop do
      prompt("What's your name?")
      name = gets.chomp.strip.squeeze(' ')
      break unless name.empty?
      prompt("Sorry, you must enter a value.")
    end
    @name = name.capitalize
  end
end

class Computer < Player
  def initialize(marker)
    super()
    @marker = marker
    @name = "Computer"
  end

  def computer_moves(board, human_marker)
    square = board.best_move_choice(marker, human_marker)

    board[square] = marker
  end
end

class Round
  include Displayable
  attr_accessor :board
  attr_reader :human, :computer

  def initialize(human, computer, first_marker)
    @board = Board.new
    @human = human
    @computer = computer
    @current_marker = first_marker
  end

  def play
    display_board

    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board
    end

    display_result(round_winner)
    add_a_point!(round_winner)
  end

  def display_board
    prompt("You're an #{human.marker}. " \
           "#{computer.name} is an #{computer.marker}.")
    puts ''
    board.draw
    puts ''
  end

  def current_player_moves
    if @current_marker == human.marker
      human.human_moves(board)
      @current_marker = computer.marker
    else
      computer.computer_moves(board, human.marker)
      @current_marker = human.marker
    end
  end

  def round_winner
    case board.winning_marker
    when human.marker then human
    when computer.marker then computer
    end
  end

  def display_result(round_winner)
    clear_screen_and_display_board
    return prompt("#{round_winner.name} wins!") if round_winner
    prompt("The board is full.")
  end

  def add_a_point!(round_winner)
    return round_winner.add_a_point! if round_winner
    prompt("No points this round.")
  end
end

class TTTGame
  include Displayable
  include Bannerize
  attr_reader :human, :computer

  GAME_NAME     = "Tic Tac Toe".freeze
  MARKERS       = ['X', 'O']
  FIRST_TO_MOVE = :player # can be :computer, :player, or :choose
  WINNING_SCORE = 5

  def initialize
    display_welcome_message(GAME_NAME)
    @human = Human.new
    @computer = Computer.new(computer_marker)
    @first_marker = first_to_move
  end

  def computer_marker
    MARKERS.reject { |marker| marker == human.marker }.first
  end

  def first_to_move
    case FIRST_TO_MOVE
    when :player then human.marker
    when :computer then computer.marker
    when :choose then choose_first_up
    end
  end

  def choose_first_up
    return human.marker if human.request_choice(:first_up, %w[p c]) == 'p'
    computer.marker
  end

  def play
    clear
    loop do
      round = Round.new(human, computer, @first_marker)
      round.play
      break if someone_won_the_game?
      display_current_score
      break unless play_again?

      clear
      display_play_again_message
    end

    display_final_score
    display_goodbye_message(GAME_NAME)
  end

  private

  def display_current_score
    figure_line_length(human.name)
    score_banner("Current Score")

    show_score(human.name, human.score)
    show_score(computer.name, computer.score)

    prompt("First Player to #{WINNING_SCORE} points wins!")
  end

  def display_final_score
    score_banner("Final Score")

    show_score(human.name, human.score)
    show_score(computer.name, computer.score)

    display_game_winner(game_winner) if someone_won_the_game?
  end

  def game_winner
    human.score == WINNING_SCORE ? human.name : computer.name
  end

  def someone_won_the_game?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def play_again?
    human.request_choice(:play_again, %w[y n]) == 'y'
  end
end

game = TTTGame.new
game.play
