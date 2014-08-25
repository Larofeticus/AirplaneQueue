#Airplane class for use with AirplaneQueue
#constructor takes size and type arguments, then validates
#valid sizes: 'small' 'large'
#valid types: 'cargo' 'passenger'
#success creates the object, validation failure raises exception
#queueKey is used to distinguish the different queues for various size/type combintations
class Airplane

  attr_reader :size
  attr_reader :type

  def initialize (size, type)
    #validate
    raise unless (size == 'small' or size == 'large') and (type == 'passenger' or type == 'cargo')
    @size = size
    @type = type    
  end

  def queueKey
    @size + @type
  end
end
