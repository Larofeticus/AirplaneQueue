#AirplaneQueue: track several types of airplanes that wish to pass through a bottleneck. 
#Airplanes have two characteristics: A size that can be small or large
#                                    A type that can be passenger or cargo
#The methods are:
#  enqueue: accepts (String, Hash) hash determines plane type using keys :size and :type, 
#              values as strings: small, large:, passenger, cargo
#           returns true when successful, false if the plane was not enqueued for some reason
#  dequeue: removes highest priority plane from queue, returns it. returns nil if queue is empty
class AirplaneQueue
  #current number of planes in queue, not in requirments but used for testing
  attr_reader :waiting

  #this constant is used to name each accepted aircraft type and determines their 
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

  def enqueue (name, params)
    type = self._buildType(params)
    return nil unless type
    @waiting+=1
    @queue[type].push(name)
  end

  def dequeue
    return nil if @waiting == 0
    ACTYPES.each do |type|
      next if @queue[type].empty?
      @waiting-=1
      return @queue[type].shift
    end
  end

  #helper method, takes type hash from a new airplane, returns it's type string
  #or nil if it doesn't have the :size and :type keys
  def _buildType parms
    return nil unless parms.class == Hash
    return nil unless parms[:size]
    return nil unless parms[:type]
    s = "#{parms[:size]}#{parms[:type]}"
    return nil unless @queue[s]
    s
  end
end
