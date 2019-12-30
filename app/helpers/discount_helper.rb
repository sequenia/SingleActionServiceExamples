module DiscountHelper
  def discount_applicator_error(error_code)
    case error_code
    when 1
      I18n.t('services.discounts.discount_applicator.error.price_negative')
    else
      I18n.t('services.discounts.discount_applicator.error.unknown')
    end
  end
end
