# What can we add to the class to access the ivar @volume?

class Cube
  def initialize(volume)
    @volume = volume
  end
  
  def get_volume
    @volume
  end
end


# We can add a getter method 
# OR we can call instance_variable_get("@volume") on an instance of the Cube class

