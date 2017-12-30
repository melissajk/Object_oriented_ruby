class InvoiceEntry
  attr_reader :product_name
  attr_accessor :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end
end

# This program will fail when #update_quantity is called.  What's the mistake and
# how do you address it?

entry = InvoiceEntry.new('Bible', 2)
puts entry.quantity
entry.update_quantity(3)
puts entry.quantity

# You have to change quantity to @quantity OR 
# Change quantity to self.quantity and change :quantity to an attr_accessor
