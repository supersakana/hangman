# frozen_string_literal: true

# when a new game board is created
module Display
  def display_board(word, chance)
    puts '-----------------------'
    puts "Word to guess: #{word} (#{@answer})"
    puts "#{chance} Chances left"
    puts '-----------------------'
  end

  def guess_prompt
    puts 'User, make a guess...'
  end
end
