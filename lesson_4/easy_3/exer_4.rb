class Cat
  def initialize(type)
    @type = type
  end
  
  def to_s
    "I am a #{@type} cat."
  end
end

# How do we get the #to_s method to print something a bit more readable for humans?

# Add an overriding #to_s method to display the desired results

sassy = Cat.new("Himalayan")
puts sassy  # ==> "I am a Himalayan cat"

