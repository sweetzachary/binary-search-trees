require './node'

class Tree
  def initialize(arr)
    arr = arr.sort.uniq
    @root = build_tree(arr)
  end

  def build_tree(arr)
    return Node.new arr[0] if arr.length == 1

    len = arr.length
    mid = len / 2
    node = Node.new(arr[mid])
    left_arr = arr.slice(0, mid)
    right_arr = arr.slice(mid + 1, mid - 1)

    node.left = build_tree(left_arr)
    node.right = build_tree(right_arr)
    node
  end

  # kindly provided by volounteers from TOP Discord server
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end