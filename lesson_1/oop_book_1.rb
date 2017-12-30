module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model
  
  @@number_of_vehicles = 0
  
  def self.gas_mileage(miles, gallons)
    puts "This vehicle gets #{miles / gallons} miles to the gallon."
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end
  
  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles."
  end
  
  def speed_up(number)
    @current_speed += number
    puts "Increasing speed by #{number} mph."
  end
  
  def spray_paint(color)
    self.color = color
    puts "Changing the color to #{color}!"
  end
  
  def brake(number)
    @current_speed -= number
    puts "Decreasing speed by #{number} mph"
  end
  
  def current_speed
    puts "Your current speed is #{@current_speed} mph."
  end
  
  def shut_down
    @current_speed = 0
    puts "We're here!"
  end
  
  def age
    puts "This #{self.model} is #{years_old} years old."
  end

  private
  
  def years_old
    Time.now.year - self.year
  end
  
end

class MyCar < Vehicle
  DRIVE_TRAIN = "rear wheel drive"

  def to_s
    "This car is a #{@year}, #{@color} #{@model}."
  end
end

class MyTruck < Vehicle
  DRIVE_TRAIN = "Four wheel drive"
  
  include Towable
  
  def to_s
    "This truck is a #{@year}, #{@color} #{@model}."
  end
end


crown_vic = MyCar.new(1999, "Gray", "Ford Crown Victoria")
ram = MyTruck.new(2001, "Red", "Dodge Ram")
crown_vic.speed_up(60)
crown_vic.current_speed
crown_vic.brake(30)
crown_vic.current_speed
crown_vic.shut_down

crown_vic.color = "Green"
p crown_vic.color
p crown_vic.year

crown_vic.spray_paint("Green")
p crown_vic.color

MyCar.gas_mileage(400, 15)

puts crown_vic
puts ram

ram.speed_up(45)
ram.current_speed
ram.brake(25)
ram.current_speed
ram.shut_down
ram.current_speed

crown_vic.age
ram.age
