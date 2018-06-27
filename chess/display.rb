require_relative 'cursor'
require_relative 'board'
require 'colorize'
require 'byebug'

class Display
  attr_accessor :board
  attr_reader  :cursor
  
  def initialize(board)
    @cursor = Cursor.new([0,0],board)
    @board = board
  end
  
  def render
    board.grid.each_index do |idx|
      puts row_generator(idx)
    end 
    # "\u001b[44;1m"
    #at cursor_pos change square color
  end
  
  def row_generator(row_idx)
    row = ""
    cpos = cursor.cursor_pos
    
    board.grid[row_idx].each_with_index do |sq, i|
      cursor = "\u001b[46;1m #{sq.name} \u001b[0m"
      cursor_selected = "\u001b[42;1m #{sq.name} \u001b[0m"
      white = "\u001b[47;1m #{sq.name} \u001b[0m"
      red = "\u001b[41m #{sq.name} \u001b[0m"
      
      if row_idx == cpos[0] && i == cpos[1]
        # debugger
        @cursor.selected ? row << cursor_selected : row << cursor
      elsif i.even? && row_idx.even? || i.odd? && row_idx.odd?
        row << white
      else 
        row << red
      end
    end

    row
  end
  
  def register_input
    loop do
      render
      cursor.get_input
      system ("clear")
    end
  end
  
end


b = Board.new.populate
d = Display.new(b)
pos = [0,0]
b[pos].moves
