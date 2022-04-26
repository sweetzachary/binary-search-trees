class Node
  include Comparable

  def initialize(val = nil, left = nil, right = nil)
    @value = val
    @left = left
    @right = right
  end

  def child_count()
    count = 0
    count += 1 if @left
    count += 1 if @right
    count
  end

  def <=>(other)
    @value <=> other.value
  end

  attr_accessor :value, :left, :right
end
