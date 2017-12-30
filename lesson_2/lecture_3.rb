## lecture 3 ==> Collaborator Objects


class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    "Meow!"
  end
end


# class Person
#   attr_accessor :name, :pet

#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new("Robert")
# bud = Bulldog.new             # assume Bulldog class from previous assignment

# bob.pet = bud  # We've set bob's @pet ivar to 'bud', which is a Bulldog object
# p bob.pet.fetch      # => "fetching!"

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

p bob.pets           # => [#<Cat:0x00000000db24a0>, #<Bulldog:0x00000000db2478>]
                     # We can't chain methods to this because it's an array


bob.pets.each do |pet|
  puts pet.jump
end

# => jumping!
# => jumping!


