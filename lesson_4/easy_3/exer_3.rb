class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# How do we create two separate instances of this class, both with different names
# and ages?

smoky = AngryCat.new(12, "Smoky")
socks = AngryCat.new(3, "Socks")

# We create new AngryCat objects and pass different arguments in to become values
# for the age and name ivars. 

p smoky  # #<AngryCat:0x00000001d04b10 @age=12, @name="Smoky">
p socks  # #<AngryCat:0x00000001d04a70 @age=3, @name="Socks">


