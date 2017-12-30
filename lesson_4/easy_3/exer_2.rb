class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
  
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi, we get an error message.  How do we fix this?

# greeting = Hello.new
# greeting.hi

# assuming that you want to call the #hi method, you need to create a new instance
# of Hello and then call the #hi method with this instance. 

# Or you can create a class method that will create a new instance of greeting and
# call the greeting method including the argument "Hello"

Hello.hi  # ==> "Hello"

