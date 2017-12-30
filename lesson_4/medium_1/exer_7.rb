class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_information # self.information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end
end

# How can you change the method name above so that the name is more clear and 
# less repetitive  ==> self.information

# Currently you would have to call this method with
Light.light_information
# But that's repetitive as well as redundant
# Also, it's better not to use the class name in method names...
Light.information

