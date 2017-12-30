# How do you add the ability to go fast using the module Speed?

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

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

car = Car.new
car.go_fast

truck = Truck.new
truck.go_fast

# You enable the car or truck to go fast by including the module Speed.  You 
# can check by creating a new Car or Truck object and calling the go_fast method
# with the object.

