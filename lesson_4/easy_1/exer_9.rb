# The name of the cats_count method refers to 'self'.  What is being referenced here?

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# self.cats_count is a class method and self is referring to the class. 

