class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# case 1

# hello = Hello.new
# hello.hi  # ==>  "Hello"

# case 2

# hello = Hello.new
# hello.bye  # undefined method error a Hello object can't access a Goodbye method

# case 3

# hello = Hello.new
# hello.greet  # argument error - expecting 1, entered 0

# case 4

# hello = Hello.new
# hello.greet("Goodbye")  # ==> Goodbye

# case 5 

# Hello.hi  # undefined method error (#hi is an instance method, not a class method)










