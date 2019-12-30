class Api::V1::DiscountsController < Api::V1::BaseController
  include DiscountHelper

  def index
    result = discount_applicator.call(index_params)
    if result.success?
      @discount = result.data
    else
      error_response discount_applicator_error(result.error_code)
    end
  end

  protected

  def index_params
    params.permit(:price)
  end

  private

  def discount_applicator
    Discounts::DiscountApplicator.new
  end
end
