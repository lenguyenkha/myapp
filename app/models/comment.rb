class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :content, presence: true, length: {maximum: Settings.comments.max_length_content}
  scope :desc_created_at, ->{order created_at: :desc}
end
