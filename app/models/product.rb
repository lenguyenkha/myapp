require "roo"
class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :ratings, dependent: :destroy
  delegate :name, to: :category, prefix: :category, allow_nil: true
  validates :name, presence: true
  validates :detail, presence: true
  validates :price, presence: true, numericality: true
  validates :quantity, presence: true, numericality: {only_integer: true}
  validate :picture_size
  mount_uploader :picture, PictureUploader
  scope :filter_by_alphabet, ->(alpha){where("name LIKE ?", "#{alpha}%") if alpha.present?}
  scope :filter_by_name, ->(name){where("name LIKE ?", "%#{name}%") if name.present?}
  scope :filter_by_category, ->(category_id){where(category_id: category_id) if category_id.present?}
  scope :filter_by_min_price, ->(min_price){where("price >= ?", min_price) if min_price.present?}
  scope :filter_by_max_price, ->(max_price){where("price <= ?", max_price) if max_price.present?}
  scope :filter_by_rate, (lambda do |rate|
    select("products.*").joins("JOIN ratings r ON products.id = r.product_id")
    .group(:id, :name, :price, :quantity, :detail, :picture, :category_id, :created_at, :updated_at)
    .having("ROUND(AVG(rate)) = ?", rate)
  end)
  scope :hot_trend, (lambda do
    select("products.*").joins(:order_details)
    .group(:id, :name, :price, :quantity, :detail, :picture, :category_id, :created_at, :updated_at)
    .order("SUM(order_details.quantity) DESC").limit Settings.products.hot_trend_record
  end)

  def average_rating
    (result = ratings.average :rate) ? result : 0
  end

  class << self
    def filter_product params
      result = Product.all
      result = result.filter_by_alphabet params[:alpha] if params[:alpha].present?
      result = result.filter_by_name params[:name] if params[:name].present?
      result = result.filter_by_category params[:category_id] if params[:category_id].present?
      result = result.filter_by_min_price params[:min_price] if params[:min_price].present?
      result = result.filter_by_max_price params[:max_price] if params[:max_price].present?
      result = result.filter_by_rate params[:rate] if params[:rate].present?
      result
    end

    def import file
      spreadsheet = file
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        product = find_or_initialize_by(id: row["id"])
        next unless product.update_attributes(row.to_hash)
      end
    end
  end

  private

  def picture_size
    return unless picture.size > Settings.products.max_size_image_file.megabytes
    errors.add :picture, I18n.t("admin.products.image_oversize")
  end
end
