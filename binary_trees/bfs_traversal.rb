require_relative '../helpers/tree_node'

# Use BFS to walkthrough a tree and print an array of values

# Iterative approach uses a queue to keep track of parent and child nodes.
# Nodes are pushed onto queue once then removed once: Time = O(n)
# The queue will only grow to the size of the number of nodes: Space = O(n)

# You can't really do this recursively given that under the hood recursive methods
# use a stack while here you use a queue.

def breadth_first_traversal(root)
  return [] if root.nil?

  queue = [root]
  values = []

  until queue.empty?
    current = queue.shift
    values << current.value # node is visited when removed from the queue

    queue.push(current.left) if current.left
    queue.push(current.right) if current.right
  end
  values
end

# TEST CASES

# FIRST
breadth_first_traversal(nil) #=> []

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
p breadth_first_traversal(root) #=> a, b, c, d, e, f

# THIRD
root = TreeNode.new('a')
b = TreeNode.new('b')
c = TreeNode.new('c')
d = TreeNode.new('d')
e = TreeNode.new('e')
x = TreeNode.new('x')

root.right = b
b.left = c
c.left = x
c.right = d
d.right = e
#    a
#     \
#      b
#     /
#    c
#  /  \
# x   d
#      \
#       e
p breadth_first_traversal(root) #=> a, b, c, x, d, e
