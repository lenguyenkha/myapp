class Order < ApplicationRecord
  enum status: {pending: 0, accept: 1, reject: 2}
  belongs_to :user
  has_many :order_details, dependent: :destroy
  delegate :email, to: :user, prefix: :user, allow_nil: true
  delegate :name, to: :user, prefix: :user, allow_nil: true
  scope :created_at_desc, ->{order created_at: :desc}
  scope :rank, ->(start){select("@row:=@row+1 as rank, orders.*").from("orders, (SELECT @row:=#{start}) as r")}
  scope :total_on, ->(date){where("date(created_at) = ?", date).sum("total")}
end
