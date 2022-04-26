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

  def delete(val)
    @root = delete_node(@root, val)
  end

  def find(val)
    find_node(@root, val)
  end

  def level_order
    queue = []
    result = []
    queue.unshift @root
    until queue.empty?
      # dequeue node
      node = queue.pop
      # process node
      if block_given?
        yield node
      else
        result.append node.value
      end
      # enqueue children
      queue.unshift node.left unless node.left.nil?
      queue.unshift node.right unless node.right.nil?
    end
    result unless block_given?
  end

  def inorder
    traverse_inorder @root
  end

  def preorder
    traverse_preorder @root
  end

  def postorder
    traverse_postorder @root
  end

  def height(node)
    return -1 if node.nil?

    1 + [height(node.left), height(node.right)].max
  end

  def depth(node)
    node_depth(@root, node, 0)
  end

  def balanced?
    result = true
    self.level_order { |n| result &&= node_balanced?(n) }
    result
  end

  def rebalance
    return if balanced?

    @root = build_tree(inorder)
  end

  # kindly provided by volounteers from TOP Discord server
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def node_balanced?(node)
    (height(node.left) - height(node.right)).abs < 2
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

  def delete_node(node, val)
    if val < node.value
      node.left = delete_node(node.left, val)
    elsif val > node.value
      node.right = delete_node(node.right, val)
    else
      case node.child_count
      when 0
        node = nil
      when 1
        node = node.left || node.right
      when 2
        node.value = minimum(node.right).value
        node.right = delete_node(node.right, node.value)
      end
    end
    node
  end

  def find_node(node, val)
    return nil if node.nil?

    case val <=> node.value
    when -1
      find_node(node.left, val)
    when 0
      node
    when 1
      find_node(node.right, val)
    end
  end

  def minimum(node)
    return node if node.left.nil?

    minimum(node.left)
  end

  def traverse_inorder(node)
    return [] if node.nil?

    values = []
    left = traverse_inorder(node.left)
    if block_given?
      yield node
    else
      values.append node.value
    end
    right = traverse_inorder(node.right)

    left + values + right unless block_given?
  end

  def traverse_preorder(node)
    return [] if node.nil?

    values = []
    if block_given?
      yield node
    else
      values.append node.value
    end
    left = traverse_preorder(node.left)
    right = traverse_preorder(node.right)

    values + left + right unless block_given?
  end

  def traverse_postorder(node)
    return [] if node.nil?

    values = []
    left = traverse_postorder(node.left)
    right = traverse_postorder(node.right)
    if block_given?
      yield node
    else
      values.append node.value
    end

    left + right + values unless block_given?
  end

  def node_depth(node, goal, count)
    return count if node == goal
    return nil if node.nil?

    count += 1
    node_depth(node.left, goal, count) || node_depth(node.right, goal, count)
  end
end

tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
tree.pretty_print
p tree.balanced?
tree.insert(21)
tree.insert 23
tree.insert 24
tree.insert 25
p tree.balanced?
tree.pretty_print
tree.delete(13)
tree.delete(6)
tree.pretty_print
p tree.find(90)
p tree.find(4)
p tree.find(14).left.value
p tree.level_order
p tree.inorder
p tree.height(tree.find(11))
p tree.height(tree.find(4))
p tree.depth(tree.find(4))
p tree.balanced?
p tree.height(tree.find(11))
root = tree.find(11)
p (tree.height(root.left) - tree.height(root.right)).abs

p tree.inorder
tree.rebalance
tree.pretty_print
p tree.balanced?