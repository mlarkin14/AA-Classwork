require "colorize"
require_relative "cursor.rb"
require_relative 'board.rb'


class Display
  attr_reader :board
  
  def initialize(board) # how to we pass board into display w/o showing two boards
    @cursor = Cursor.new([0,0], board)
    @board = board
  end
  
  def build_grid
    @board.rows
  
  def render # will this render correctly?
    board.grid.each_with_index do |row, i|
      row.each_index do |j|
        if [i, j] == @cursor.cursor_pos
          print " #{[i, j]} ".colorize(:blue)
        else
          print " #{[i, j]} "
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

