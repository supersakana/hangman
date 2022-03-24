# frozen_string_literal: true

require_relative 'display'

# includes methods for saving and retriving saved files
module Save
  include Display

  def new_file(data)
    Dir.mkdir('output') unless Dir.exist?('output')
    saved_file = "output/#{@player.name}.yml"
    File.open(saved_file, 'w') { |file| file.write(data) }
  end

  def save_game
    new_file(@game_data)
    puts 'Saved game'
    exit
  end
end
