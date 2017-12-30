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

# What does the @@cats_count variable do and how does it work?

# @cats_count is a class variable that increments by a value of one each time a
# new instance of Cat is created.  

# Testing

mittens = Cat.new('Black')
cody = Cat.new('Himalayan')
tiger = Cat.new('Tabby')


puts Cat.cats_count

# Or you can call the variable after it's been incremented in the initialize 
# method
