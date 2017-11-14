require 'byebug'
require 'singleton'

class Piece
  attr_reader :symbol 
  attr_accessor :current_pos
  def initialize(start_pos, color, board)
    @current_pos = start_pos
    @color = color
    @board = board
    # take out once pieces are set
     # change at each class to its specific symbol
  end
  
  def self.moves
    move_set = moves_dirs
    move_positions(move_set)
  end
  
  # def track_position
  #   # update current_pos for the movement that occurred in last move
  #   # 
  # end  
  
  module SlidingPiece

    def moves_dirs
      if self.class == Bishop
        :diagonal
      elsif self.class == Rook
        :hor_and_vert
      else
        :all
      end
    end
    
    def move_positions(piece_symbol)
      case piece_symbol
      when :diagonal
        [[1, -1], [1, 1], [-1, 1], [-1, -1]]
      when :hor_and_vert
        [[0, 1], [0, -1], [-1, 0], [1, 0]]
      else 
        [[0, 1], [0, -1], [-1, 0], [1, 0],[1, -1], [1, 1], [-1, 1], [-1, -1]]
      end
    end
  # 
  end
  
  module SteppingPiece
    
    def moves_dirs
      if self.class == Knight
        :l_shape
      else
        :all
      end
    end
    
    def move_positions(piece_symbol)
      case piece_symbol
      when :l_shape
        [[1, 2], [-1, 2], [1, -2], [-1, -2], [-2, 1], [-2, -1], [2, 1], [2, -1]]
      else 
        [[0, 1], [0, -1], [-1, 0], [1, 0], [1, -1], [1, 1], [-1, 1], [-1, -1]]
      end
    end

  end
end



class NullPiece < Piece
  include Singleton
  def initialize
    @symbol = "   "
  end
end

class Bishop < Piece
  include SlidingPiece
  def initialize(start_pos, color, board)
    super
    @symbol = :BP
  end
  
end

class Rook < Piece
  include SlidingPiece
  def initialize(start_pos, color, board)
    super
    @symbol = :RK
  end
end

class Queen < Piece
  include SlidingPiece
  def initialize(start_pos, color, board)
    super
    @symbol = :QN
  end
end

class Knight < Piece
  include SteppingPiece
  def initialize(start_pos, color, board)
    super
    @symbol = :KT
  end
end

class King < Piece
  include SteppingPiece
  def initialize(start_pos, color, board)
    super
    @symbol = :KG
  end
end

class Pawn < Piece
  def initialize(start_pos, color, board)
    super
    @symbol = :PN
  end # call super from piece and check if pawn has moved from start positions
  # => if past start position can only move 1, can move at most 2 on first turn.
end
  