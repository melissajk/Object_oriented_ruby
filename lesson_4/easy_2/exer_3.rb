module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# What is the lookup chain for Orange and HotSauce? How can you find out?

# Orange, Taste, Object, Kernel, BasicObject
# HotSauce, Taste, Object...

# To find out call Class.ancestors -- REMEMBER!  This only works when calling on
# the class itself and not an instance of the class. 

p Orange.ancestors
p HotSauce.ancestors

