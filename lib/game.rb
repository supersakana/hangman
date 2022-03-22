# frozen_string_literal: true

require_relative 'intro'
require_relative 'display'

# when a new game is created
class Game
  include Display
  include Intro

  def initialize
    @guess_word = nil
    @guess = nil
    @chances = 6
  end

  def game
    instructions
    gets
    create_word
    game_loop
  end

  def create_word
    word_file = File.open('google-10000-english-no-swears.txt')
    words = word_file.readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }
    @guess_word = words.sample
  end

  def game_loop
    until @chances.zero?
      display_board(@guess_word, @chances)
      make_your_move
    end
  end

  def make_your_move
    guess_prompt
    @guess = gets.chomp.upcase
    puts "This is your guess: #{@guess}"
  end
end
