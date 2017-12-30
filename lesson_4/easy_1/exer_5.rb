# Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Pizza class has an instance variable and I know because there is a variable 
# beginning with @ in the initialize method. 
# ALSO!  You can check by using the #instance_variables method on an object from
# the class 



