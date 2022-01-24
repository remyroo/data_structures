require_relative '../linked_list_stack_queue'

# rubocop:disable Metrics/BlockLength

describe LinkedList::Stack do
  subject(:stack) { described_class.new }

  describe '#push' do
    context 'when stack is empty' do
      it 'returns the head' do
        node = stack.push(1)
        expect(stack.head).to eq node
      end
    end

    context 'when stack is not empty' do
      it 'adds a new node to the head' do
        stack.push(1)
        expect { stack.push(2) }.to change { stack.head.data }.from(1).to(2)
      end

      it 'sets a pointer from the new head to the next node' do
        old_head = stack.push(1)
        new_head = stack.push(2)
        expect(new_head.next_node).to eq old_head
      end
    end
  end

  describe '#pop' do
    context 'when the stack is empty' do
      it 'raises error' do
        expect { stack.pop }.to raise_error(RuntimeError, 'Stack is empty')
      end
    end

    context 'when the stack is not empty' do
      before do
        stack.push(1)
        stack.push(2)
      end

      it 'removes the head node' do
        popped_node = stack.pop
        expect(popped_node.data).to eq 2
        expect(stack.head).not_to be popped_node
      end

      it 'sets the next node as the new head node' do
        stack.pop
        expect(stack.head.data).to eq 1
      end
    end
  end

  describe '#peek' do
    context 'when stack is empty' do
      it 'raises error' do
        expect { stack.peek }.to raise_error(RuntimeError, 'Stack is empty')
      end
    end

    context 'when stack is not empty' do
      it 'returns the head node' do
        head_node = stack.push(1)
        result = stack.peek
        expect(result).to eq head_node
      end
    end
  end

  describe '#size' do
    context 'when stack is empty' do
      it 'returns zero' do
        result = stack.size
        expect(result).to eq 0
      end
    end

    context 'when stack has 2 items' do
      before do
        2.times { |i| stack.push(i) }
      end

      it 'returns the total size' do
        result = stack.size
        expect(result).to eq 2
      end

      context 'when 1 item is removed' do
        it 'decrements the size' do
          expect { stack.pop }.to change { stack.size }.from(2).to(1)
        end
      end

      context 'when 1 item is added' do
        it 'increments the size' do
          expect { stack.push(3) }.to change { stack.size }.from(2).to(3)
        end
      end
    end
  end
end

describe LinkedList::Queue do
  subject(:queue) { described_class.new }

  describe '#enqueue' do
    context 'when queue is empty' do
      it 'returns the new node' do
        new_node = queue.enqueue(1)
        expect(queue.head).to eq new_node
        expect(queue.tail).to eq new_node
      end
    end

    context 'when queue is not empty' do
      before { queue.enqueue(1) }

      it 'adds a new node to the tail' do
        new_node = queue.enqueue(2)
        expect(queue.tail).to eq new_node
      end

      it 'sets a pointer from the head to the new tail' do
        expect(queue.head.next_node).to be_nil
        new_node = queue.enqueue(2)
        expect(queue.head.next_node).to eq new_node
      end
    end
  end

  describe '#dequeue' do
    context 'when the queue is empty' do
      it 'raises error' do
        expect { queue.dequeue }.to raise_error(RuntimeError, 'Queue is empty')
      end
    end

    context 'when the queue is not empty' do
      before do
        queue.enqueue(1)
        queue.enqueue(2)
      end

      it 'removes the head node' do
        dequeued_node = queue.dequeue
        expect(dequeued_node.data).to eq 1
        expect(queue.head).not_to be dequeued_node
      end

      it 'updates the head' do
        queue.dequeue
        expect(queue.head.data).to eq 2
      end

      it 'updates the tail' do
        2.times { queue.dequeue }
        expect(queue.tail).to be_nil
      end
    end
  end

  describe '#peek' do
    context 'when queue is empty' do
      it 'raises error' do
        expect { queue.peek }.to raise_error(RuntimeError, 'Queue is empty')
      end
    end

    context 'when queue is not empty' do
      it 'returns head node' do
        head_node = queue.enqueue(1)
        result = queue.peek
        expect(result).to eq head_node
      end
    end
  end

  describe '#size' do
    context 'when queue is empty' do
      it 'returns zero' do
        result = queue.size
        expect(result).to eq 0
      end
    end

    context 'when queue has 2 items' do
      before do
        2.times { |i| queue.enqueue(i) }
      end

      it 'returns 2' do
        result = queue.size
        expect(result).to eq 2
      end

      context 'when 1 item is removed' do
        it 'decrements the size' do
          expect { queue.dequeue }.to change { queue.size }.from(2).to(1)
        end
      end

      context 'when 1 item is added' do
        it 'increments the size' do
          expect { queue.enqueue(3) }.to change { queue.size }.from(2).to(3)
        end
      end
    end
  end
end
