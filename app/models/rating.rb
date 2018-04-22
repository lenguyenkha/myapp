class Rating < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :rate, presence: true
  validate  :rate_range

  private

  def rate_range
    return unless rate < Settings.products.star_min || rate > Settings.products.star_max
    errors.add :rate, I18n.t("products.rating_form.invalid_rate")
  end
end
