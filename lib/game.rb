# frozen_string_literal: true

require_relative 'intro'
require_relative 'save'
require_relative 'display'
require_relative 'player'

# when a new game is created
class Game
  include Display
  include Intro
  include Save

  def initialize
    @game_data = nil
    @player = nil
    @answer = nil
    @answer_hidden = nil
    @guess = nil
    @guess_list = []
    @chances = 6
  end

  def game_data
    @game_data = {
      player: @player,
      answer: @answer,
      answer_hidden: @answer_hidden,
      guess: @guess,
      guess_list: @guess_list,
      chances: @chances
    }
  end

  def game
    introduction
    create_player
    create_word
    hide_answer(@answer)
    game_loop
  end

  def create_player
    player_message
    @player = Player.new(gets.chomp)
    welcome_player(@player.name)
  end

  def create_word
    word_file = File.open('../google-10000-english-no-swears.txt')
    words = word_file.readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }
    @answer = words.sample
  end

  def hide_answer(answer)
    @answer_hidden = answer.split('').map { ' _ ' }
  end

  def game_loop
    until @chances.zero? || @answer_hidden.join('') == @answer
      display_board(@answer_hidden.join(''), @chances)
      make_your_move
      game_data
    end
    display_winner
  end

  def make_your_move
    guess_prompt(@player.name)
    @guess = gets.chomp.downcase unless @guess == 'save'
    validate_guess(@guess)
    @guess
  end

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

  def guess_checker(guess)
    if @answer.split('').include?(guess)
      guess_reveal(guess)
    else
      @chances -= 1
    end
  end

  def guess_reveal(guess)
    @answer.split('').each_with_index do |char, index|
      next unless char == guess.to_s

      @answer_hidden[index] = guess
    end
  end

  def display_winner
    @answer_hidden.join('') == @answer ? user_wins(@player.name) : user_looses(@player.name)
  end
end
