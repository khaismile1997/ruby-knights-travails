require 'active_support/all'

class MoveNode
  attr_reader :position, :parent

  TRANSFORMATIONS = [
    [2,1],
    [-2,1],
    [1,2],
    [-1,2],
    [1,-2],
    [-1,-2],
    [2,-1],
    [-2,-1]
  ].freeze
  
  @@rails = Array.new

  def initialize(position, parent)
    @position = position
    @parent = parent
    @@rails.push(position)
  end

  def children
    TRANSFORMATIONS.map {[_1 + @position.first, _2 + @position.second]}
                   .keep_if { valid?(_1) }
                   .select { @@rails.exclude?(_1) }
                   .map { MoveNode.new(_1, self) }
  end

  def valid?(position)
    position.first.between?(0, 7) && position.second.between?(0, 7)
  end
end

def display_parent(node)
  display_parent(node.parent) unless node.parent.nil?
  print node.position
end

def knight_travails(p_start, p_end)
  queue = []
  current_node = MoveNode.new(p_start, nil)
  until current_node.position == p_end
    current_node.children.each {queue.push(_1)}
    current_node = queue.shift
  end

  display_parent(current_node)
end

# knight_travails([0,0],[1,2])
# knight_travails([0,0],[3,3])
# knight_travails([3,3],[0,0])
# knight_travails([1,2],[0,0])

knight_travails([0,0], [7,7])
