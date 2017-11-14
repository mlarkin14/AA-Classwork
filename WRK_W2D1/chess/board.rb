require 'byebug'

require_relative 'pieces.rb'
require_relative 'display.rb'

class Board
  class PieceMoveError < StandardError; end

  attr_reader :rows


  def initialize
    @rows = Array.new(8) {Array.new(8, NullPiece.instance)}
    # @display = Display.new(self)
    fill_board
  end

  def length
    @rows.length
  end
  
  def move_piece(start_pos, end_pos)
    if self[start_pos].class == NullPiece || self[end_pos].class != NullPiece
      raise PieceMoveError.new("Error moving piece. Check positions") # add rescue statement where called
    else
      piece = self.dup[start_pos] #actually moving the piece on the board?
      self[start_pos], self[end_pos] = self[end_pos], self[start_pos] 
      # self[end_pos] = piece
      piece.current_pos = end_pos
    end
  end

  def [](pos)
    x, y = pos
    @rows[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @rows[x][y] = value
  end

  def in_bounds?(cursor_pos) #only use for piece
    x, y = cursor_pos
    x < 8 && x > 0
    y < 8 && y > 0
  end

  private 
  
  def fill_board # should this be a factory method? Why? Think instance is fine.
    # debugger
    rows[0][0] = Rook.new([0, 0], self)
    rows[0][1] = Knight.new([0, 1], self)
    rows[0][2] = Bishop.new([0, 2], self)
    rows[0][3] = King.new([0, 3], self)
    rows[0][4] = Queen.new([0, 4], self)
    rows[0][5] = Bishop.new([0, 5], self)
    rows[0][6] = Knight.new([0, 6], self)
    rows[0][7] = Rook.new([0, 7], self)
    rows[1].map!.with_index { |pos, idx| pos = Pawn.new([1, idx], self) }
    
    # rows[2..5].each_index do |idx|
    #   idx += 2 # since 1 NullClass, push into array the positions in this area?
    #   rows[idx].map! { |pos| pos = null_piece.symbol }
    # end
    
    rows[6].map!.with_index { |pos, idx| pos = Pawn.new([6, idx], self) }
    rows[7][0] = Rook.new([7, 0], self)
    rows[7][1] = Knight.new([7, 1], self)
    rows[7][2] = Bishop.new([7, 2], self)
    rows[7][3] = King.new([7, 3], self)
    rows[7][4] = Queen.new([7, 4], self)
    rows[7][5] = Bishop.new([7, 5], self)
    rows[7][6] = Knight.new([7, 6], self)
    rows[7][7] = Rook.new([7, 7], self)
  end    
    # @rows.each_with_index do |row, idx| # same each but with case statement for positions
      
  #     if idx <= 1 || idx >= 6
  #       row.map!.with_index do |_, p_idx|
  #         row[p_idx] = Piece.new(idx, p_idx)
  #       end
  #     else
  #       row.map!.with_index do |_, null_idx|
  #         row[null_idx] = Piece.new(idx, null_idx)
  #       end
  #     end
  #   end
  # end
end
