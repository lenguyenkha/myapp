module Admin
  class OrderDetailsController < AdminBaseController
    before_action :find_order, only: :index

    def index
      page = valid_page params[:page]
      per_page = Settings.admin.order_details.number_of_order_details
      @order_details = @order.order_details.rank((page - 1) * per_page).paginate page: page,
        per_page: per_page
      respond_to do |format|
        format.html
        format.js
      end
    end

    private

    def find_order
      @order = Order.find_by id: params[:order_id]
      return if @order
      flash[:danger] = t "admin.orders.not_found_order"
      redirect_to admin_orders_path
    end
  end
end
