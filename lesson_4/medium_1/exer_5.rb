# if filling type only ==> flavor
# if filling type is nil ==> plain
# if glazing           ===> "with *flavor*"
# if both              ===> flavor with glazing


class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
  
  def filling_type
    return "Plain" if @filling_type.nil?
    @filling_type
  end
  
  def glazing
    return '' if @glazing.nil?
    " with #{@glazing}"
  end
  
  def to_s
    filling_type + glazing
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
 # => "Plain"

puts donut2
 # => "Vanilla"

puts donut3
 # => "Plain with sugar"

puts donut4
 # => "Plain with chocolate sprinkles"

puts donut5
 # => "Custard with icing"
 
# LS Solution
# class KrispyKreme
#   def initialize(filling_type, glazing)
#     @filling_type = filling_type
#     @glazing = glazing
#   end
  
#   def to_s
#     filling_string = @filling_type ? @filling_type : "Plain"
#     glazing_string = @glazing ? " with #{@glazing}" : ""
#     filling_string + glazing_string
#   end
# end

