class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# This code creates an instance variable with the #create_template method and
# calls the value of template with the #show_template method which is actually 
# calling the getter method created by the attr_accessor method. 

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    template  # self isn't needed here -- only in the setter method
  end
end

# This code does basically the same thing, except with self, which is needed for
# the setter method, but not for the getter method

computer = Computer.new
computer.create_template
puts computer.show_template