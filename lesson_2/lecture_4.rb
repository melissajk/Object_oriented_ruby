## Lecture 4 ==> Modules

module Swim
  def swim
    "swimming!"
  end
end

class Pet
end

class Fish < Pet
  include Swim
end

class Mammals < Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end


class Dog < Mammals
  include Swim
  def speak
    'bark!'
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

class Cat < Mammals
  def speak
    "Meow!"
  end
end

p Dog.ancestors  # => [Dog, Swim, Mammals, Pet, Object, Kernel, BasicObject]
p Fish.ancestors  # => [Fish, Swim, Pet, Object, Kernel, BasicObject]
p Cat.ancestors  # => [Cat, Mammals, Pet, Object, Kernel, BasicObject]
p Bulldog.ancestors  # => [Bulldog, Dog, Swim, Mammals, Pet, Object, Kernel, BasicObject]
p Mammals.ancestors  # => [Mammals, Pet, Object, Kernel, BasicObject]
p Pet.ancestors  # => [Pet, Object, Kernel, BasicObject]


