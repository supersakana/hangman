# frozen_string_literal: true

require 'json'

require_relative 'display'

# includes methods for saving and retriving saved files
module Data
  include Display

  def new_file(hash)
    new_hash = JSON.dump(hash)
    Dir.mkdir('output') unless Dir.exist?('output')
    saved_file = "output/#{@player.downcase}.json"
    File.open(saved_file, 'w') { |file| file.write(new_hash) }
  end

  def save_game
    new_file(@game_data)
    puts 'Saved game'
    exit
  end

  def show_files
    Dir.entries('output').each { |file| puts file.delete '.json' }
  end

  def open_file(file)
    saved_file = File.read("output/#{file}.json")
    JSON.parse(saved_file)
  end

  def update_data(file)
    @game_data = file
    @player = @game_data['player']
    @answer = @game_data['answer']
    @answer_hidden = @game_data['answer_hidden']
    @guess = @game_data['guess']
    @guess_list = @game_data['guess_list']
    @chances = @game_data['chances']
    game_loop
  end
end
