# frozen_string_literal: true

require 'json'

require_relative 'game'
def instructions
  puts <<~HEREDOC

    Welcome to Hangman!

    This is a 1 player game.

    The goal of the player is to break the CPU code with only 6 chances.

    If you guess correctly, your chances remain.

    If you guess incorrectly, you deduct 1 chance.

    Let's begin!

    (Click ENTER to start!)

  HEREDOC
end

instructions
gets
start = Game.new
start.game
