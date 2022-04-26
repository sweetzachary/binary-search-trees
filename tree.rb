require './node'

class Tree
  def initialize(arr)
    arr = arr.sort.uniq
    @root = build_tree(arr)
  end

  def build_tree(arr)
    return nil if arr.nil? || arr.empty?

    len = arr.length
    mid = len / 2
    node = Node.new arr[mid]
    left_arr = arr.slice(0, mid)
    right_arr = arr.slice(mid + 1, mid - 1)

    node.left = build_tree(left_arr)
    node.right = build_tree(right_arr)
    node
  end

  def insert(val)
    return if val.nil?
    insert_node(@root, val)
  end

  def insert_node(node, val)
    if val < node.value
      if node.left.nil?
        node.left = Node.new val
      else
        insert_node(node.left, val)
      end
    elsif val > node.value
      if node.right.nil?
        node.right = Node.new val
      else
        insert_node(node.right, val)
      end
    end
  end

  def delete()
  end


  # kindly provided by volounteers from TOP Discord server
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
tree.pretty_print
tree.insert(21)
tree.pretty_print
