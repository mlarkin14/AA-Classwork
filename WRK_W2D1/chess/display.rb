require 'byebug'
require "colorize"
require_relative "cursor.rb"
require_relative 'board.rb'


class Display
  attr_reader :board

  def initialize(board) # how to we pass board into display w/o showing two boards
    @cursor = Cursor.new([0, 0], board)
    @board = board
  end
  #
  # def build_grid
  #   @board.rows

  def render # will this render correctly?
    system('clear')
    board.rows.each do |row|
      puts ""
      # debugger
      row.each do |el|
        if el.is_a?(NullPiece)
          print "| #{el.symbol} | "
        else
          print "| #{el.symbol}  | "
        end
      end
    end
  end

  def test_board # is this what you mean by looping? Small script
    while true
      self.render
      @cursor.get_input
    end
  end


end

if $PROGRAM_NAME == __FILE__
  display = Display.new(Board.new)
  display.test_board
end
