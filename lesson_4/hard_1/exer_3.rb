module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class FloatingVehicle
  attr_accessor :propeller_count, :hull_count
  include Moveable
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.propeller_count = num_propellers
    self.hull_count = num_hulls
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end
end

class Motorboat < FloatingVehicle
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up the motorboat to have one hull and propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

class Catamaran < FloatingVehicle
end

# We combine the constructor method of the Cataraman and Motorboat class and 
# put it in the FloatingVehicle class which defines number of hull, number of props
# fuel effeciency and fuel capacity.  The Motorboat class has only one hull and prop
# so the constructor method has to be set up differently than the FloatingVehicle class
# The Catamaran just inherits its constructor class from FloatingVehicle

#  Still not too clear about the self prefix... Is it because the attributes 
# are passed into a module?

car = Auto.new
motorcycle = Motorcycle.new

puts car.range
puts motorcycle.range

