class Stack
  def initialize
    @items = []
  end

  def push(item)
    @items << item
  end

  def pop
    @items.empty? ? nil : @items.pop
  end

  def peek
    # return the last item without removing it
    @items.empty? ? nil : @items[-1]
  end
end

puts 'Stack'
stack = Stack.new
p stack.push(5)
p stack.push(3)
p stack.pop #=> 3
p stack.peek #=> 5

# Access the largest element in a stack
class MaxStack
  # time: O(1) for push, pop, max | space: O(m) m = number of operations on second stack
  def initialize
    @stack = Stack.new
    @maxes_stack = Stack.new
  end

  # if maxes is empty or new item is larger than latest item, add to maxes_stack
  def push(item)
    @maxes_stack.push(item) if !@maxes_stack.peek || item >= @maxes_stack.peek
    @stack.push(item)
  end

  def pop
    item = @stack.pop
    @maxes_stack.pop if item == @maxes_stack.peek
    item
  end

  def peek
    @stack.peek
  end

  def max
    @maxes_stack.peek
  end
end

puts "\nMax stack"
max_stack = MaxStack.new
p max_stack.push(5)
p max_stack.max #=> 5
p max_stack.push(4)
p max_stack.push(7)
p max_stack.push(6)
p max_stack.push(8)
p max_stack.max #=> 8
p max_stack.pop #=> 8
p max_stack.max #=> 7
p max_stack.peek #=> 6
