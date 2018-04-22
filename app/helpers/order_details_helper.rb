module OrderDetailsHelper
  def calc_price unit_price, quantity
    unit_price * quantity
  end

  def no_order counter
    counter + 1
  end
end
