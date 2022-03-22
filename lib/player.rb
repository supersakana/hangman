# frozen_string_literal: true

# when a new player is created
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
