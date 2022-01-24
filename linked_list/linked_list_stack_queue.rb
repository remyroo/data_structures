require_relative '../helpers/node'

module LinkedList
  class Stack
    attr_accessor :head, :size

    def initialize
      @head = nil
      @size = 0
    end

    # each method runs in O(1) time
    def push(data)
      new_node = Node.new(data)

      if empty?
        @head = new_node
      else
        old_head = @head
        @head = new_node
        @head.next_node = old_head
      end

      @size += 1
      @head
    end

    def pop
      raise 'Stack is empty' if empty?

      old_head = @head
      @head = old_head.next_node
      @size -= 1
      old_head
    end

    def peek
      raise 'Stack is empty' if empty?

      @head
    end

    def empty?
      @head.nil?
    end
  end

  class Queue
    attr_accessor :head, :tail, :size

    # each method runs in O(1) time
    def initialize
      @head = nil
      @tail = nil
      @size = 0
    end

    def enqueue(data)
      new_node = Node.new(data)

      if empty?
        @head = new_node
      else
        @tail.next_node = new_node
      end

      @size += 1
      @tail = new_node
    end

    def dequeue
      raise 'Queue is empty' if empty?

      old_head = @head
      @head = old_head.next_node
      @tail = nil if empty?
      @size -= 1
      old_head
    end

    def peek
      raise 'Queue is empty' if empty?

      @head
    end

    def empty?
      @head.nil?
    end
  end
end

# stack and queue in action:
def run_stack
  puts "\nA Stack"
  stack = LinkedList::Stack.new

  %w[Hi There].each { |data| stack.push(data) }
  p stack

  begin
    3.times { puts stack.pop.data }
  rescue RuntimeError => e
    puts "Error - #{e.message}"
  end
end

def run_queue
  puts "\nA Queue"
  queue = LinkedList::Queue.new

  %w[Hi There].each { |data| queue.enqueue(data) }
  p queue

  begin
    3.times { puts queue.dequeue.data }
  rescue RuntimeError => e
    puts "Error - #{e.message}"
  end
end

run_stack
run_queue
