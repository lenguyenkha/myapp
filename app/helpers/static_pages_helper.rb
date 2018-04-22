module StaticPagesHelper
  def find_product category, page_category
    return unless category
    list_child_id = category.find_childs_id_to_array
    list_child_id << category.id
    Product.filter_by_category(list_child_id).paginate page: page_category,
      per_page: Settings.home.number_of_products
  end
end
