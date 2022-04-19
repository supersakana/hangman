# frozen_string_literal: true

require 'json'

require_relative 'data'
require_relative 'display'
require_relative 'player'

# when a new game is created
class Game
  include Data
  include Display

  # when a new game is created
  def initialize
    @game_data = nil
    @player = nil
    @answer = nil
    @answer_hidden = nil
    @guess = nil
    @guess_list = []
    @chances = 6
  end

  # basic gameplay
  def game
    load_game if Dir.exist?('output')
    create_player if @player.nil?
    create_word
    hide_answer(@answer)
    game_loop
  end

  # displays saved games to choose from
  def load_game
    opening_message
    show_files
    choice = gets.chomp
    return unless Dir.entries('output').include?("#{choice}.json")

    choosen_file = open_file(choice)
    update_data(choosen_file)
  end

  # creates a new player
  def create_player
    player_message
    @player = Player.new(gets.chomp).name
    welcome_player(@player)
  end

  # cpu generates random word from file between 5-12 chars long
  def create_word
    word_file = File.open('../google-10000-english-no-swears.txt')
    words = word_file.readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }
    @answer = words.sample
  end

  # takes cpu generated word and only displays blank char spaces
  def hide_answer(answer)
    @answer_hidden = answer.split('').map { ' _ ' }
  end

  # basic game loop
  def game_loop
    until @chances.zero? || @answer_hidden.join('') == @answer
      display_board(@answer_hidden.join(''), @chances)
      make_your_move
      game_data
    end
    display_winner
  end

  # fetches guess from player
  def make_your_move
    guess_prompt(@player)
    @guess = gets.chomp.downcase unless @guess == 'save'
    validate_guess(@guess)
    @guess
  end

  # validates if guess is a single letter or 'save'
  def validate_guess(guess)
    alpha = ('a'..'z').to_a
    if guess == 'save'
      save_game
    elsif guess.length > 1 || guess.empty? || alpha.none?(guess.to_s)
      invalid_guess
      make_your_move
    else
      guess_checker(guess)
      @guess_list.push(guess)
    end
  end

  # checks if guess matches a char from the cpu's answer
  def guess_checker(guess)
    if @answer.split('').include?(guess)
      guess_reveal(guess)
    else
      @chances -= 1
    end
  end

  # updates the hidden answer with correct guess
  def guess_reveal(guess)
    @answer.split('').each_with_index do |char, index|
      next unless char == guess.to_s

      @answer_hidden[index] = guess
    end
  end

  # displays if user won or lost with replay prompt
  def display_winner
    @answer_hidden.join('') == @answer ? user_wins(@player) : user_looses(@player)
    replay
  end

  # player choice to replay or exit
  def replay
    replay_message
    choice = gets.chomp
    if choice == 'yes'
      refresh_data
      game
    else
      exit_message
      exit
    end
  end

  # restarts game data for new game
  def refresh_data
    @game_data = nil
    @guess_list = []
    @chances = 6
  end
end
