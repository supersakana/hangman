# frozen_string_literal: true

require_relative 'intro'
require_relative 'display'

# when a new game is created
class Game
  include Display
  include Intro

  def initialize
    @answer = nil
    @answer_hidden = nil
    @guess = nil
    @guess_list = []
    @chances = 6
  end

  def game
    introduction
    create_word
    hide_answer(@answer)
    game_loop
  end

  def create_word
    word_file = File.open('../google-10000-english-no-swears.txt')
    words = word_file.readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }
    @answer = words.sample
  end

  def game_loop
    until @chances.zero?
      display_board(@answer_hidden, @chances)
      make_your_move
    end
  end

  def make_your_move
    guess_prompt
    @guess = gets.chomp.downcase
    validate_guess(@guess)
    @guess
  end

  def hide_answer(word)
    @answer_hidden = word.split('').map { ' _ ' }.join('')
  end

  def validate_guess(char)
    alpha = ('a'..'z').to_a
    if char.length > 1 || char.empty? || alpha.none?(char.to_s)
      invalid_guess
      make_your_move
    else
      @guess_list.push(char)
    end
  end
end
