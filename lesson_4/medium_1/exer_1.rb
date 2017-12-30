class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Do you need an @balance on #positive_balance?

# No, because there is an attr_accessor for balance in this class. Ruby will
# automatically set up a method called balance that will get the value of @balance
# #positive_balance? is actually using a method called balance instead of a variable.

account = BankAccount.new(200)
puts account.positive_balance?  # ==> true
account1 = BankAccount.new(0)
puts account1.positive_balance? # ==> true
account2 = BankAccount.new(-50)
puts account2.positive_balance? # ==> false

