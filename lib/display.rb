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

  def guess_prompt
    puts 'User, make a guess...'
  end

  def invalid_guess
    puts 'Invalid Guess (Must be a single character letter)'
  end
end
