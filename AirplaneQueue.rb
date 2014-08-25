#AirplaneQueue: track several types of airplanes that wish to pass through a bottleneck. 
#The methods are:
#  enqueue: accepts Airplane object 
#  dequeue: removes highest priority plane from queue, returns it's object. returns nil if queue is empty
class AirplaneQueue
  #current number of planes in queue, not in requirments but used for testing
  attr_reader :waiting

  #this constant is used to name each accepted aircraft size/type combination and determines their 
  #relative priority, 0 is highest
  ACTYPES = ["largepassenger","smallpassenger","largecargo","smallcargo"]

  #the state is stored in @queue, which is a Hash of ACTYPES to arrays, of which each array
  #holds all plane name strings  of the corresponding type in the order of their arrival

  def initialize
    @waiting = 0
    @queue = { }
    #initialize a queue for each type of ac
    ACTYPES.each { |type| @queue[type] = [] } 
  end

  def enqueue (a)
    return nil unless a.class == Airplane 
    @waiting+=1
    @queue[a.queueKey].push(a)
  end

  def dequeue
    return nil if @waiting == 0
    ACTYPES.each do |type|   #visit queue in order of AC priority, if it's not empty shift and return
      next if @queue[type].empty?
      @waiting-=1
      return @queue[type].shift
    end
  end
end
