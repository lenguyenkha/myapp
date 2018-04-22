module Admin
  module CategoriesHelper
    def render_category_select_tag form, category, id = 0
      id = category.id if category.id
      categories = Category.not_self(id)
      form.collection_select :parent_id, categories, :id, :name, {}, class: "form-control"
    end

    def list_category_include_new_root category_array = []
      category_array << Category.new(id: Settings.categories.root_id, name: t("admin.categories.root_category"))
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
