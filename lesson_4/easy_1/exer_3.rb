# How is the type of vehicle included in the string?

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

car = Car.new
car.go_fast  # "I am a Car and going super fast!"

# The go_fast method returns a string that interpolates the object's class into
# the string. 




