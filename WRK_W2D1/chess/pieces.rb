class Piece
  attr_reader :symbol
  def initialize
    @symbol = :P
  end
end

class NullPiece < Piece
  def initialize
    @symbol = :NP
  end
end
