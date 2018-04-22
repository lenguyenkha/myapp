module Admin
  class OrdersController < AdminBaseController
    before_action :find_order, only: :update

    def index
      page = valid_page params[:page]
      per_page = Settings.admin.orders.number_of_orders
      @orders = Order.created_at_desc.rank((page - 1) * per_page).paginate page: page,
        per_page: per_page
      respond_to do |format|
        format.html
        format.js
      end
    end

    def update
      status = params[:status].to_i
      if (check_status status) && (@order.update_attribute :status, status)
        Admin::OrderMailer.admin_respon(@order.user, @order).deliver_now
        @order.order_details.each(&:return_quantity_when_reject) if @order.reject?
        flash[:success] = t ".update_success"
      else
        flash[:danger] = t ".update_failed"
      end
      redirect_to admin_orders_path
    end

    private

    def find_order
      @order = Order.find_by id: params[:id]
      return if @order
      flash[:danger] = t "admin.orders.not_found_order"
      redirect_to admin_orders_path
    end

    def check_status status
      array = Order.statuses.values
      true if array.include? status
    end
  end
end
