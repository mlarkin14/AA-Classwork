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
    # debugger
    system('clear')
    board.rows.each_with_index do |row, idx|
      puts ""
      row.each_with_index do |el, idx2|
        if el.is_a?(NullPiece)
          if @cursor.cursor_pos == [idx, idx2]  
            print "| #{el.symbol}| ".colorize(:green)
          else
            print "| #{el.symbol}| ".colorize(:red)
          end
        else
          if @cursor.cursor_pos == [idx, idx2]  
            print "| #{el.symbol} | ".colorize(:green)
          else
            print "| #{el.symbol} | ".colorize(:blue)
          end
        end
      end
    end
  end

  def test_board # is this what you mean by looping? Small script
    run = true
    while run
      self.render
      @cursor.get_input
      puts "Enter a start pos:"
      start_pos = gets.chomp
      start_pos = start_pos.split("").map(&:to_i)
      puts "Enter an end pos:"
      end_pos = gets.chomp
      end_pos = end_pos.split("").map(&:to_i)
      board.move_piece(start_pos, end_pos)
      # debugger
      # self.render
      # @cursor.get_input
      # debugger
    end
  end


end

if $PROGRAM_NAME == __FILE__
  display = Display.new(Board.new)
  display.test_board
end
