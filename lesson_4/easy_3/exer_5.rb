class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if you called the methods as shown below?

tv = Television.new
tv.manufacturer  # ==> method error -- trying to call a class method with an instance
tv.model         # ==> method logic

Television.manufacturer  # ==> method logic
Television.model         # ==> method error -- trying to call an instance method with a class

