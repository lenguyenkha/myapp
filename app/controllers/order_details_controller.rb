class OrderDetailsController < ApplicationController
  before_action :logged_in_user, :find_order, only: %i(index)

  def index
    @order_details = @order.order_details.paginate page: valid_page(params[:page]),
      per_page: Settings.orders.number_of_orders
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def find_order
    @order = @current_user.orders.find_by id: params[:order_id]
    return if @order
    flash[:danger] = t "orders.not_found_order"
    redirect_to orders_path
  end
end
