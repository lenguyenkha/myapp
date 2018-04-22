class Suggest < ApplicationRecord
  enum status: {pending: 0, accept: 1, reject: 2}
  belongs_to :user
  belongs_to :category
  delegate :name, to: :category, prefix: :category, allow_nil: true
  delegate :email, to: :user, prefix: :user, allow_nil: true
  validates :product_name, presence: true, length: {maximum: Settings.suggests.max_length_name}
  validates :detail, presence: true, length: {maximum: Settings.suggests.max_length_detail}
end
