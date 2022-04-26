require './tree'

puts 'Creating a tree from an array:'
tree = Tree.new p Array.new(15) { rand(1..100) }
puts "Is the tree balanced? #{tree.balanced?}"
puts 'Level order:'
p tree.level_order
puts 'Preorder:'
p tree.preorder
puts 'Postorder:'
p tree.postorder
puts 'Inorder:'
p tree.inorder
Array.new(6) { rand(101..1000) }.each {|n| tree.insert n}
puts "Is the tree balanced? #{tree.balanced?}"
tree.rebalance
puts "Is the tree balanced? #{tree.balanced?}"
puts 'Level order:'
p tree.level_order
puts 'Preorder:'
p tree.preorder
puts 'Postorder:'
p tree.postorder
puts 'Inorder:'
p tree.inorder
