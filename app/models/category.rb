class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :childs, foreign_key: "parent_id", class_name: Category.name, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.categories.max_length_name}
  validate :parent_not_found_and_self
  scope :root_categories, ->{where parent_id: Settings.categories.root_id}
  scope :not_self, ->(id){where("id != ?", id)}

  def find_childs_id_to_array
    children_array = []
    childs.all.find_each do |child|
      children_array << child.id
      children_array << child.find_childs_id_to_array
    end
    children_array.flatten
  end

  def all_children symbol = I18n.t("categories.level"), level = 0
    children_array = []
    level += 1
    childs.all.find_each do |child|
      child.name = symbol.to_s * level + child.name
      children_array << child
      children_array << child.all_children(symbol, level)
    end
    children_array.flatten
  end

  private

  def parent_not_found_and_self
    return if (parent_id != id) && ((Category.find_by id: parent_id) || parent_id == Settings.categories.root_id)
    errors.add(:parent_id, I18n.t("admin.categories.not_valid_parent"))
  end
end
