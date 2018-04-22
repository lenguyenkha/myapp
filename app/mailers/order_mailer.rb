class OrderMailer < ApplicationMailer
  def user_order order
    @order = order
    admin = User.find_by is_admin: true
    @greeting = t(".greeting", name: admin.name)
    @message = t(".message", order_id: order.id)
    @order_details = @order.order_details
    mail to: admin.email, subject: t(".new_order")
  end
end
