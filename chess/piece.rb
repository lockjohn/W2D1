require "singleton"

class Piece
  attr_reader :name
  attr_accessor :pos
  
  def initialize(start_pos)
    @pos = start_pos
    @name = "♔"
  end
  
  def update_position(position)
    self.pos = position
  end
  
end

class NullPiece < Piece
  include Singleton
  
  def initialize
    super(nil)
    @name = nil
  end
end