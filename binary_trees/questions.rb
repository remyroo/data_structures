require_relative '../helpers/tree_node'

# Tree Includes: write a method that takes the root of a binary tree and a
# target value. The method should return a boolean indicating whether the target
# value is contained in the tree or not.
puts 'TREE INCLUDES'

# BFS approach:
def tree_includes(root, target) # rubocop:disable Metrics/MethodLength
  return false if root.nil?

  queue = [root]
  result = false

  until queue.empty?
    current = queue.shift
    result = (current.value == target)
    break if result

    queue.push(current.left) if current.left
    queue.push(current.right) if current.right
  end

  result
end

# DFS approach:
def recursive_tree_includes(root, target)
  return false if root.nil?
  return true if root.value == target

  recursive_tree_includes(root.left, target) || recursive_tree_includes(root.right, target)
end

# TEST CASES

root = TreeNode.new('a')
b = TreeNode.new('b')
c = TreeNode.new('c')
d = TreeNode.new('d')
e = TreeNode.new('e')
f = TreeNode.new('f')

root.left = b
root.right = c
b.left = d
b.right = e
c.right = f

tree_includes(root, 'e') #=> true
tree_includes(root, 'z') #=> false
tree_includes(nil, 's') #=> false

p recursive_tree_includes(root, 'e') #=> true
p recursive_tree_includes(root, 'z') #=> false
p recursive_tree_includes(nil, 's') #=> false

# TREE SUM: write a method that takes the root of a binary tree and returns the
# total sum of all values in the tree.
puts "\nTREE SUM"

# BFS
def tree_sum(root)
  return 0 if root.nil?

  queue = [root]
  total = 0

  until queue.empty?
    current = queue.shift
    total += current.value

    queue.push(current.left) if current.left
    queue.push(current.right) if current.right
  end

  total
end

# DFS
def recursive_tree_sum(root)
  return 0 if root.nil?

  root.value + recursive_tree_sum(root.left) + recursive_tree_sum(root.right)
end

# TEST CASES

# FIRST
tree_sum(nil) #=> 0
p recursive_tree_sum(nil) #=> 0

# SECOND
root = TreeNode.new(3)
b = TreeNode.new(11)
c = TreeNode.new(4)
d = TreeNode.new(4)
e = TreeNode.new(-2)
f = TreeNode.new(1)

root.left = b
root.right = c
b.left = d
b.right = e
c.right = f
tree_sum(root) #=> 21
p recursive_tree_sum(root) #=> 21

# TREE MIN VALUE: write a method that takes the root of a binary tree and returns
# the minimum value within the tree. You may assume that the input tree is non-empty.
puts "\nTREE MIN VAL"

# Iterative approach (could be either DFS/stack or BFS/queue)
def tree_min_val(root)
  stack = [root]
  min_value = Float::INFINITY

  until stack.empty?
    current = stack.pop
    min_value = [current.value, min_value].min

    stack.push(current.left) if current.left
    stack.push(current.right) if current.right
  end

  min_value
end

# Recursive approach
def recursive_tree_min_val(root)
  return Float::INFINITY if root.nil?

  left_min = recursive_tree_min_val(root.left)
  right_min = recursive_tree_min_val(root.right)

  p [root.value, left_min, right_min].min
end

# TEST CASES

# FIRST
tree_min_val(TreeNode.new(42)) #=> 42
p recursive_tree_min_val(TreeNode.new(42)) #=> 42

# SECOND
root = TreeNode.new(3)
b = TreeNode.new(11)
c = TreeNode.new(4)
d = TreeNode.new(4)
e = TreeNode.new(-2)
f = TreeNode.new(1)

root.left = b
root.right = c
b.left = d
b.right = e
c.right = f
tree_min_val(root) #=> -2
p recursive_tree_min_val(root) #=> -2

# MAX PATH SUM: Write a method that takes the root of a binary tree and returns
# the maximum sum of any root to leaf path within the tree.
puts "\nMAX PATH SUM"

# Recursive approach: ideal for path finding.
def recursive_max_path_sum(root)
  return -Float::INFINITY if root.nil?
  return root.value if root.left.nil? && root.right.nil? # return leaf node value

  max_left_path = recursive_max_path_sum(root.left)
  max_right_path = recursive_max_path_sum(root.right)

  max_child_path = [max_left_path, max_right_path].max
  root.value + max_child_path
end

# TEST CASES

# FIRST
p recursive_max_path_sum(TreeNode.new(42)) #=> 42

# SECOND
root = TreeNode.new(3)
b = TreeNode.new(11)
c = TreeNode.new(4)
d = TreeNode.new(4)
e = TreeNode.new(-2)
f = TreeNode.new(1)

root.left = b
root.right = c
b.left = d
b.right = e
c.right = f
#       3
#    /    \
#   11     4
#  / \      \
# 4   -2     1
p recursive_max_path_sum(root) #=> 18
