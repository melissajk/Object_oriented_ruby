#What does 'self' refer to in the #make_one_year_older method?

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# 'Self' refers to the calling object (an instance of the Cat class)
