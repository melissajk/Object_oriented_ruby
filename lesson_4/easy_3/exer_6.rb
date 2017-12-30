class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1  # OR you can use @age += 1 
  end
end

# Whats another way to write #make_one_year_older so that you don't have to use
# self?

boots = Cat.new("Calico")
boots.make_one_year_older
boots.make_one_year_older
puts boots.age # => 2

# In this case self and @ are the same and can be used interchangeably



