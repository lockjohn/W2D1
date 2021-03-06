require_relative "piece"
require 'byebug'
class Board
  
  attr_reader :grid
  
  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end
  
  def [](pos)
    x, y = pos
    @grid[x][y]
  end
  
  def []=(pos,value)
    x,y = pos
    @grid[x][y] = value
  end
  
  def populate
    @grid.each.with_index do |row,i|
      row.each_index do |j|
        if i <= 1
          row[j] = Piece.generate([i, j], self, :black)
        elsif i >= 6
          row[j] = Piece.generate([i, j], self, :white)
        else
          row[j] = NullPiece.instance
        end 
      end 
    end 
    
    self
  end
  
  def move_piece(start_pos, end_pos)
    #update 2d grid
    #update piece objects position
    #raise errors
    raise "No piece" if self[start_pos].is_a?(NullPiece)
    raise "Occupied" unless self[end_pos].is_a?(NullPiece)
    
    start_piece = self[start_pos]
    null_piece = self[end_pos]
    
    start_piece.update_position(end_pos)
    self[start_pos] = null_piece
    self[end_pos] = start_piece
  end
  
  def valid_pos?(pos)
    (pos[0].between?(0,7) && pos[1].between?(0,7)) ? true : false
  end
  
end

# load 'board.rb'
# b = Board.new.populate
# start_pos = [0,0]
# end_pos = [2,0]
# b.move_piece(start_pos, end_pos)
# rint b.[](pos)