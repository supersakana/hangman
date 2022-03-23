# frozen_string_literal: true

# methods for saving and loading a game
module Save
  def make_dir
    Dir.mkdir('output') unless Dir.exist?('output')
  end
end
