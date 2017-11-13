require 'byebug'
require_relative 'skeleton/lib/00_tree_node.rb'

class KnightPathFinder
  MOVES = [[1,2], [-1,2], [2,1], [2,-1], [-2,1], [-2,-1], [-1,-2], [1,-2]]

  attr_reader :visited_pos, :move_tree

  def initialize(starting_pos)
    @visited_pos = [starting_pos]
    @move_tree = build_move_tree(starting_pos)
  end

  def self.valid_moves(current_pos)
    possible_pos = MOVES.map do |move|
      move.map.with_index do |pos, idx|
        current_pos[idx] + pos
      end
    end
  end

  def new_move_positions(current_pos)
    possible_moves = self.class.valid_moves(current_pos)

    filtered_moves = possible_moves.reject do |move|
      KnightPathFinder.outside_range?(move) || @visited_pos.include?(move)
    end

    visit_positions(filtered_moves)

    filtered_moves
  end

  def self.outside_range?(move)
    move.each do |pos|
      return true if pos < 0 || pos > 8
    end
    false
  end

  def visit_positions(moves)
    @visited_pos += moves
  end

  def build_move_tree(starting_pos)
    root_node = PolyTreeNode.new(starting_pos)
    queue = [root_node]
    debugger
    until queue.empty?
      current_node = queue.shift
      new_move_array = self.new_move_positions(current_node.value)

      new_move_array.each do |move|
        next_move_node = PolyTreeNode.new(move)
        next_move_node.parent = current_node
        queue << next_move_node
      end
    end
    root_node
  end

end
