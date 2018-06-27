require 'byebug'

module SlidingPiece
  
  DIRECTIONS = { left: [0,-1], right: [0,1], up: [-1,0], down: [1,0],
  upleft: [-1,-1], upright: [-1,1], downleft: [1,-1], downright: [1,1] }
  
  def moves 
    dirs = move_dirs
    moves = []
    
    dirs.each do |dir|
      moves += grow_unblocked_moves_in_dir(DIRECTIONS[dir])
    end 
    
    moves.select! {|move| board.valid_pos?(move)}
    
    moves
  end
  
  def move_dirs
    # debugger
    if self.is_a?(Queen)
      [:left, :right, :down, :up, :upleft, :upright, :downleft, :downright]
    elsif self.is_a?(Rook)
      [:left, :right, :down, :up]
    # when "Bishop"
    #   [:upleft, :upright, :downleft, :downright]
    end
  end
  
  def grow_unblocked_moves_in_dir(pos_change)
    dx, dy = pos_change
    moves = []
    current_pos = @pos
    blocked = false
    
    until blocked
      current_pos = [current_pos[0] + dx, current_pos[1] + dy]
      if board[current_pos].is_a?(NullPiece)
        moves << current_pos
      elsif board[current_pos].is_a?(Piece) && color != board[current_pos].color
        moves << current_pos
        blocked = true
      else
        blocked = true
      end 
    end 
    
    moves
  end
  
  module SteppingPiece
    
    def moves 
      diffs = move_diffs
      moves = []
      
      diffs.each do |diff|
        new_pos = [@pos[0] + diff[0], @pos[1] + diff[1]]
        if board[new_pos].is_a?(NullPiece)
          moves << new_pos
        elsif board[new_pos].is_a?(Piece) && color != board[new_pos].color
          moves << new_pos
        end
      end 
      
      moves.select! {|move| board.valid_pos?(move)}
      
      moves
    end
    
    def move_diffs
      if self.is_a?(Knight)
        [[-2,1],[-2,-1],[2,1],[2,-1],[1,-2],[-1,-2],[1,2],[-1,2]]
      elsif self.is_a?(King)
        [[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[-1,1],[1,1],[1,-1]]
      end
    end
    
  end 
end