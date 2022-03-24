# frozen_string_literal: true

require 'json'

require_relative 'display'

# includes methods for saving and retriving saved files
module Save
  include Display

  def new_file(hash)
    hash.to_json
    Dir.mkdir('output') unless Dir.exist?('output')
    saved_file = "output/#{@player.name.downcase}.json"
    File.open(saved_file, 'w') { |file| file.write(hash) }
  end

  def save_game
    new_file(@game_data)
    puts 'Saved game'
    exit
  end

  def resume_game
    puts open_message
    show_files
    choice = gets.chomp
    open_file(choice) if Dir.entries('output').include?("#{choice}.json")
  end
end

def show_files
  Dir.entries('output').each { |file| puts file.delete '.json' }
end

def open_file(file)
  puts "File to open: #{file}.json"

  saved_file = File.read("output/#{file}.json")
  # puts saved_file
  data = JSON.parse(saved_file)
  puts data
  exit
end
