require 'spec_helper'

describe AirplaneQueue do
  
  before :each do
    @aq = AirplaneQueue.new
  end

  describe 'initialize' do
    it 'creates an empty airplane queue' do
      expect(@aq.waiting).to eq 0
    end
  end
  
  describe 'enqueue' do
    it 'increases waiting count after success' do
      @aq.enqueue(Airplane.new('small', 'cargo'))
      expect(@aq.waiting).to eq 1
    end
  end
  
  describe 'dequeue' do
    it 'returns nil when all queues are empty' do
      expect(@aq.dequeue).to eq nil
    end
    it 'returns a plane that has been queued' do
      a = Airplane.new('small', 'cargo')
      @aq.enqueue(a)
      expect(@aq.dequeue).to eq a
    end
    it 'decreases waiting count after dequeue' do
      @aq.enqueue(Airplane.new('small', 'cargo'))
      @aq.dequeue
      expect(@aq.waiting).to eq 0
    end
  end
  
  #test patterns of operations to cover some of the more complex behavior expected
  describe 'priority behavior' do
    it 'allows for the storage of an arbitrarily large number of planes' do
      (1..99).each {|n| @aq.enqueue(Airplane.new('small','cargo'))}
      a = Airplane.new('small', 'cargo')
      @aq.enqueue(a)
      (1..99).each {|n| @aq.dequeue}
      expect(@aq.dequeue).to eq a
    end
    it 'dequeues passenger planes first when passenger and cargo are waiting' do
      @aq.enqueue(Airplane.new('large', 'cargo'))
      @aq.enqueue(Airplane.new('small', 'passenger'))
      expect(@aq.dequeue.queueKey).to eq 'smallpassenger'
    end
    it 'dequeues large planes before small planes when they are the same type' do
      @aq.enqueue(Airplane.new('small', 'cargo'))
      @aq.enqueue(Airplane.new('large', 'cargo'))
      expect(@aq.dequeue.queueKey).to eq 'largecargo'
    end
    it 'returns planes of the same type in FIFO order' do
      a = Airplane.new('small', 'passenger')
      @aq.enqueue(a)
      @aq.enqueue(Airplane.new('small', 'passenger'))
      expect(@aq.dequeue).to eq a
    end
  end
end
