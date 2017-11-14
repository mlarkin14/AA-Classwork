require 'byebug'

require_relative 'pieces.rb'
require_relative 'display.rb'

class Board
  class PieceMoveError < StandardError; end

  attr_reader :rows


  def initialize
    @rows = Array.new(8) {Array.new(8)}
    # @display = Display.new(self)
    self.fill_board
  end

  def fill_board # should this be a factory method? Why? Think instance is fine.
    @rows.each_with_index do |row, idx|
      # debugger
      if idx <= 1 || idx >= 6
        row.map!.with_index do |_, p_idx|
          row[p_idx] = Piece.new
        end
      else
        row.map!.with_index do |_, null_idx|
          row[null_idx] = NullPiece.new
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].nil? || !self[end_pos].nil?
      raise PieceMoveError.new("Error moving piece. Check positions")
    else
      piece = self.dup[start_pos]
      self[start_pos] = nil
      self[end_pos] = piece
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

  def in_bounds?(cursor_pos)
    x, y = cursor_pos
    x < 8 && x > 0
    y < 8 && y > 0
  end

end
