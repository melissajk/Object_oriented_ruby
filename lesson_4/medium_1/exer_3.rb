class InvoiceEntry
  attr_reader :product_name
  attr_accessor :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end

# This is one of the ways to correct the problem of quantity in the update_quantity method.
# However, this creates another problem in that it's now possible to change the value
# of quantity from outside of the class. 



