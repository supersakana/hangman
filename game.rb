# frozen_string_literal: true

require_relative 'intro'

# when a new game is created
class Game
  include Intro

  def initialize
    @guess_word = nil
  end

  def game
    puts instructions
    create_word
    puts @guess_word
  end

  def create_word
    word_file = File.open('google-10000-english-no-swears.txt')
    words = word_file.readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }
    @guess_word = words.sample
  end
end

start = Game.new
start.game
