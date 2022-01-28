require_relative '../helpers/tree_node'

# Use DFS to walkthrough a tree and print an array of values

# Iterative approach uses a stack to keep track of parent and child nodes
# Nodes are pushed onto stack once then removed once: Time = O(n)
# The stack will only grow to the size of the number of nodes: Space = O(n)
def depth_first_traversal(root) # preorder traversal
  return [] if root.nil?

  stack = [root]
  values = []

  until stack.empty?
    current = stack.pop
    values << current.value
    stack.push(current.right) if current.right
    stack.push(current.left) if current.left
  end

  values
end

# Recursive approach. Under the hood, recursive calls are also stored on the stack
# in the same order as the iterative approach.
def recursive_df_traversal(root)
  return [] if root.nil? # base case

  left = recursive_df_traversal(root.left)
  right = recursive_df_traversal(root.right)

  [root.value, *left, *right]
end

# TEST CASES

# FIRST
depth_first_traversal(nil) #=> []
p recursive_df_traversal(nil) #=> []

# SECOND
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
#        a
#      /  \
#     b    c
#   /  \    \
#  d    e    f
depth_first_traversal(root) #=> a, b, d, e, c, f
p recursive_df_traversal(root) #=> a, b, d, e, c, f

# THIRD
root = TreeNode.new('a')
b = TreeNode.new('b')
c = TreeNode.new('c')
d = TreeNode.new('d')
e = TreeNode.new('e')

root.right = b
b.left = c
c.right = d
d.right = e
#    a
#     \
#      b
#     /
#    c
#     \
#      d
#       \
#        e
depth_first_traversal(root) #=> a, b, c, d, e
p recursive_df_traversal(root) #=> a, b, c, d, e
