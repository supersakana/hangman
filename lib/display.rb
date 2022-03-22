# frozen_string_literal: true

# when a new game board is created
module Display
  def display_board(answer, chance)
    puts '-----------------------'
    puts "Guesses: #{@guess_list.join(',') unless @guess_list.empty?}"
    puts "Word to guess: #{answer} (#{@answer})"
    puts "#{chance} Chance(s) left"
    puts '-----------------------'
  end

  def player_message
    puts 'What is your name?'
  end

  def welcome_player(name)
    puts "Welcome #{name}, let's begin..."
  end

  def guess_prompt(name)
    puts "#{name}, make a guess..."
  end

  def invalid_guess
    puts 'Invalid Guess (Must be a single letter a-z)'
  end

  def user_wins(name)
    puts "Congrats #{name}! You win!"
  end

  def user_looses(name)
    puts "Sorry #{name}. You loose."
  end
end
