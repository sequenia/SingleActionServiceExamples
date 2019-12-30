class Discounts::DiscountApplicator < SingleActionService::Base
  ERROR_CODE_PRICE_NEGATIVE = 1

  PRICE_FOR_BIG_DISCOUNT = BigDecimal('100')
  SMALL_DISCOUNT_PERCENTS = 5
  BIG_DISCOUNT_PERCENTS = 10

  def call(params)
    price = params[:price].to_f
    validation_result = validate_price(price)
    return validation_result unless validation_result.success?

    total_price = calculate_price_with_discount(price)
    success init_discount(price, total_price)
  end

  protected

  def validate_price(price)
    return error if price.nil?
    return error(price, code: ERROR_CODE_PRICE_NEGATIVE) if price.negative?

    success
  end

  def calculate_price_with_discount(price)
    discount_percents = find_discount_percents(price)
    add_discount_to_price(price, discount_percents)
  end

  def find_discount_percents(price)
    if price >= PRICE_FOR_BIG_DISCOUNT
      BIG_DISCOUNT_PERCENTS
    else
      SMALL_DISCOUNT_PERCENTS
    end
  end

  def add_discount_to_price(price, discount_percents)
    price - price * (discount_percents / BigDecimal('100'))
  end

  private

  def init_discount(price, total_price)
    Discount.new(
      value: price - total_price,
      original_price: price,
      total_price: total_price
    )
  end
end
