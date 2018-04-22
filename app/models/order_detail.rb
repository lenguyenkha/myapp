class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  delegate :name, to: :product, prefix: :product, allow_nil: true
  delegate :price, to: :product, prefix: :product, allow_nil: true
  delegate :picture, to: :product, prefix: :product, allow_nil: true
  delegate :quantity, to: :product, prefix: :product, allow_nil: true
  validates :quantity, presence: true, numericality: {only_integer: true}
  before_destroy :return_quantity_when_reject
  after_save :update_order_total_price
  scope :rank, ->(start){select("@r:=@r+1 as rank, order_details.*").from("order_details, (SELECT @r:=#{start}) as r")}

  def return_quantity_when_reject
    product.update_attribute :quantity, product_quantity + quantity if order.pending? || order.reject?
  end

  private

  def update_order_total_price
    order.update_attribute :total, (order.total + product_price * quantity)
    product.update_attribute :quantity, product_quantity - quantity
  end
end
