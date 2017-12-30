class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

class BeesWax
  attr_accessor :type
  def initialize(type)
    @type = type
  end
  
  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

nun_ya = BeesWax.new("nun ya")
nun_ya.describe_type

# What can you add to the class to simplify it and remove to methods from the 
# class definition while maintaining functionality?

# You can add an accessor method!  It also allows us to remove the @ from the 
# ivar in the #describe_type method



