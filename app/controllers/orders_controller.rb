class OrdersController < ApplicationController
  before_action :logged_in_user, only: %i(index destroy create)
  before_action :current_order, only: %i(create)
  before_action :find_order, only: %i(destroy)

  def index
    @orders = @current_user.orders.created_at_desc.paginate page: valid_page(params[:page]),
      per_page: Settings.orders.number_of_orders
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @order = @current_user.orders.new
    session[:shopping_cart].each do |item|
      @order.order_details << @order.order_details.new(item)
    end
    if @order.save
      flash[:success] = t ".order_success"
      OrderMailer.user_order(@order).deliver_now
      session[:shopping_cart] = []
    else
      flash[:danger] = t ".order_failed"
    end
    redirect_to cart_path
  end

  def destroy
    if @order.pending? && @order.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to orders_path
  end

  private

  def find_order
    @order = @current_user.orders.find_by id: params[:id]
    return if @order
    flash[:danger] = t "orders.not_found_order"
    redirect_to orders_path
  end
end
