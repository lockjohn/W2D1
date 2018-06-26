require_relative 'cursor'
class Display
  
  def initialize(board)
    @cursor = Cursor.new([0,0],board)
    @board = board
  end
  
  def render
    @grid.each do |row|
      row.each {|piece| print piece.name}
      print "\n"
    end 
    #at cursor_pos change square color
  end
  
end