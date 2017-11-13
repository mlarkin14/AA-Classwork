require 'byebug'

class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    parent.children.delete(self) if self.parent != nil

    @parent = new_parent

    new_parent.children << self unless new_parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Not associated with parent" if !self.children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if value == target_value
    return nil if children.empty?

    children.each do |child|
      return_child = child.dfs(target_value)
      return return_child if return_child
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end
    nil
  end

  # def inspect
  #   @value.inspect
  # end

end
