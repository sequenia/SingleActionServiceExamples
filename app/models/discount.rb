class Discount
  attr_accessor :value, :original_price, :total_price
  def initialize(value: nil, original_price: nil, total_price: nil)
    @value = value
    @original_price = original_price
    @total_price = total_price
  end
end
