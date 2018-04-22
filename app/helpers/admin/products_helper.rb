module Admin
  module ProductsHelper
    def list_category
      category_array = []
      @root_categories = Category.root_categories
      @root_categories.each do |category|
        category_array << category
        category.all_children(t("categories.level_suggest")).each do |child|
          category_array << child
        end
      end
      category_array
    end
  end
end
