class Node
  include Comparable

  def initialize(val = nil, left = nil, right = snil)
    @value = val
    @left = left
    @right = right
  end

  def <=>(other)
    @value <=> other.value
  end

  attr_accessor :value, :left, :right
end