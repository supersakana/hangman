# frozen_string_literal: true

require 'json'

require_relative 'display'

# includes methods for saving and retriving saved files
module Data
  include Display

  # when the user types 'save' during gameplay
  def save_game
    new_file(@game_data)
    puts 'Saved game'
    exit
  end

  # creates new directory and save file
  def new_file(hash)
    new_hash = JSON.dump(hash)
    Dir.mkdir('output') unless Dir.exist?('output')
    saved_file = "output/#{@player.downcase}.json"
    File.open(saved_file, 'w') { |file| file.write(new_hash) }
  end

  # displays player names as files to select
  def show_files
    Dir.entries('output').each { |file| puts file[0..-6] }
  end

  # opens selected file
  def open_file(file)
    saved_file = File.read("output/#{file}.json")
    JSON.parse(saved_file)
  end

  # data to be saved each game
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

  # updates the file with game data
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
