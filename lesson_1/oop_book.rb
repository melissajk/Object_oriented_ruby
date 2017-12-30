

# module Drivable
#   def four_wheel_drive
#     puts "Engaging 4-Wheel drive!"
#   end
# end


# class Vehicle
#   attr_accessor :color
#   attr_reader :year, :model
  
#   @@number_of_vehicles = 0
  
#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @current_speed = 0
#     @@number_of_vehicles += 1
#   end
  
#   def self.total_number_of_vehicles
#     puts "This program has created #{@@number_of_vehicles} vehicles."
#   end
  
#   def self.gas_mileage(miles, gallons)
#     puts "#{(miles / gallons).to_f.round(1)} miles to the gallon."
#   end
  
#   def age
#     puts "Your #{self.model} is #{vehicle_age} years old."
#   end
  
#   def spray_paint(new_color)
#     self.color = new_color
#     puts "Your car is now #{self.color}"
#   end
  
#   def speed_up(number)
#     @current_speed += number
#     puts "You push the gas and accelerate to #{number} mph."
#   end
  
#   def brake(number)
#     @current_speed -= number
#     puts "You push the brake and decelerate to #{number} mph."
#   end
  
#   def current_speed
#     puts "You are now going #{@current_speed} mph."
#   end
  
#   def shut_down
#     @current_speed = 0
#     puts "Let's park this bad boy!"
#   end
  
#   private
  
#   def vehicle_age
#     Time.now.year - self.year
#   end
# end

# class MyCar < Vehicle

#   CAR_TYPE = 'Sedan'
  
#   def to_s
#     "Your car is a #{self.year} #{self.color} #{self.model}."
#   end
  
# end

# class MyTruck < Vehicle
#   include Drivable
  
#   TRUCK_TYPE = 'Four-wheel Drive'
  
#   def to_s 
#     "Your truck is a #{self.year} #{self.color} #{self.model}"
#   end
  
# end

# moms_car = MyCar.new(1999, 'metallic gray', 'Crown Victoria')
# puts moms_car
# moms_car.age


# grandpas_truck = MyTruck.new(2005, 'silver', 'F150')
# puts grandpas_truck
# grandpas_truck.current_speed
# grandpas_truck.speed_up(45)
# grandpas_truck.current_speed
# grandpas_truck.brake(20)
# grandpas_truck.current_speed
# grandpas_truck.shut_down
# grandpas_truck.spray_paint('metallic red')
# grandpas_truck.color


# class Student

#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end
  
#   def better_grade_than?(other_student)
#     grade > other_student.grade
#   end
  
#   protected
  
#   def grade
#     @grade
#   end
  
# end

# joe = Student.new('Joe', 85)
# susan = Student.new('Susan', 90)

# puts "Well Done!" if susan.better_grade_than?(joe)

