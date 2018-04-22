module Admin
  class OrderMailer < ApplicationMailer
    def admin_respon user, order
      @greeting = t(".greeting", name: user.name)
      @status = check_status order
      @message = t(".message", order_id: order.id, status: @status)
      mail to: user.email, subject: @status
    end

    def end_of_month_mail admin
      mail to: admin.email, subject: "Statistic Orders"
    end

    private

    def check_status order
      if order.accept?
        t ".accept"
      elsif order.reject?
        t ".reject"
      else
        t ".pending"
      end
    end
  end
end
