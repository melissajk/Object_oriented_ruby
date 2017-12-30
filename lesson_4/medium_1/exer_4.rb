class Greeting
  attr_reader :greet
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

greeting = Hello.new
greeting.hi

see_ya = Goodbye.new
see_ya.bye



