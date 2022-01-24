require_relative '../helpers/node'

head = Node.new('A')
b = Node.new('B')
c = Node.new('C')

head.next_node = b
b.next_node = c
p head
# #<Node:0x00007f8e2b0b72d0 @data="A", @next_node=#<Node:0x00007f8e2b0b71e0 @data="B", @next_node=#<Node:0x00007f8e2b0b7140 @data="C", @next_node=nil>>>

# Delete a node when you only have the reference to that node and nothing else
# within the linked list. Traversing the whole list to find the one to delete would be O(n)
def delete_node(node_to_delete)
  # time + space: O(1)
  next_node = node_to_delete.next_node

  if next_node
    # delete our node by basically turning it into the next_node node in the chain
    # the next_node will just 'disappear' since it's no longer being pointed to/referenced
    # this 'in-place' modification could cause bugs if some other pointers point to the now orphan/dangling next_node.
    node_to_delete.data = next_node.data
    node_to_delete.next_node = next_node.next_node
  else
    raise "Can't delete the last node with this technique"
  end
end
puts "\nDelete node"
delete_node(b)
p head
# #<Node:0x00007f8e2b0b72d0 @data="A", @next_node=#<Node:0x00007f8e2b0b71e0 @data="C", @next_node=nil>>

# Reverse a linked list
def reverse(head_of_list)
  # time: O(n) because we pass over the list once | space: O(1) because it's in-place
  current_node = head_of_list
  previous_node = nil

  while current_node
    next_node = current_node.next_node # copy and store the reference to the next_node node
    current_node.next_node = previous_node # reverse the 'next_node' pointer

    # step forward
    previous_node = current_node
    current_node = next_node
  end

  previous_node
  # when we exit the list, current_node is nil and the last node we visited - previous node -
  # was the tail of the original list = thus the head of our reversed list.
end
puts "\nReverse a linked list"
first = Node.new(1)
second = Node.new(2)
first.next_node = second
p 'Original:'
p first

p 'Reversed:'
p reverse(first)

# Write a method kth_to_last_node() that takes an integer kk and the head_node
# of a singly-linked list, and returns the kth to last node in the list.
def kth_to_last_node(k, head) # rubocop:disable Metrics
  # time: O(n) : space: O(1)
  raise ArgumentError, 'k must be more than 0' if k < 1

  list_length = 1
  next_node = head.next_node
  while next_node
    # walk down the whole list, counting nodes, to get the total list_length
    list_length += 1
    next_node = next_node.next_node
  end

  raise ArgumentError, 'k is larger than the length of the linked list' if k > list_length

  # subtract k from list_length to get the distance from the head to the target(kth) node
  target_distance = list_length - k

  current_node = head
  target_distance.times do
    # walk that distance to the kth node
    current_node = current_node.next_node
  end

  current_node
end

puts "\nReturn the kth to last node in the linked list."
head = Node.new('A')
b = Node.new('B')
c = Node.new('C')
d = Node.new('D')
head.next_node = b
b.next_node = c
c.next_node = d

p 'Node C'
p kth_to_last_node(2, head)
p 'Node A'
p kth_to_last_node(4, head)
