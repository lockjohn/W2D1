require "singleton"
require_relative 'board'
require 'colorize'
require_relative 'modules'

class Piece
  attr_reader :name, :color, :board
  attr_accessor :pos
  
  def initialize(start_pos = nil, board = nil, color = nil)
    @board = board
    @color = color
    @pos = start_pos
    if color == :black
      @name = "♚"
    elsif color == :white
      @name = "♔"
    else
      @name = " "
    end 
  end
  
  def self.generate(start_pos, board, color)
    if start_pos == [0,0] || start_pos == [0,7] || start_pos == [7,0] || start_pos == [7,7]
      Rook.new(start_pos, board, color)
    elsif start_pos == [0,1] || start_pos == [0,6] || start_pos == [7,1] || start_pos == [7,6]
      Knight.new(start_pos, board, color)
    elsif start_pos == [0,2] || start_pos == [0,5] || start_pos == [7,2] || start_pos == [7,5]
      Bishop.new(start_pos, board, color)
    elsif start_pos == [0,3] || start_pos == [7,4]
      Queen.new(start_pos, board, color)
    elsif start_pos == [0,4] || start_pos == [7,3]
      King.new(start_pos, board, color)
    elsif start_pos[0] == 1 || start_pos[0] == 6
      Pawn.new(start_pos, board, color)
    end
  end
  
  def update_position(position)
    self.pos = position
  end
  
  def moves

    #moves possible for this piece  an array
  end
end

class Rook < Piece
  include SlidingPiece
  
  def initialize(start_pos, board, color)
    super
    color == :white ? @name = "♖" : @name = "♜"
  end  
end

class Bishop < Piece
  include SlidingPiece
  
  def initialize(start_pos, board, color)
    super
    color == :white ? @name = "♗" : @name = "♝"
  end
end

class Queen < Piece
  include SlidingPiece
  
  def initialize(start_pos, board, color)
    super
    color == :white ? @name = "♕" : @name = "♛"
  end 
end

class King < Piece
  
  def initialize(start_pos, board, color)
    super
    color == :white ? @name = "♔" : @name = "♚"
  end 
  
end 

class Knight < Piece
  
  def initialize(start_pos, board, color)
    super
    color == :white ? @name = "♘" : @name = "♞"
  end 
  
end 

class Pawn < Piece
  
  def initialize(start_pos, board, color)
    super
    color == :white ? @name = "♙" : @name = "♟"
  end 
  
end 

class NullPiece < Piece
  include Singleton

end