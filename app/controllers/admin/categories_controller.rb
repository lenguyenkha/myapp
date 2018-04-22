module Admin
  class CategoriesController < AdminBaseController
    before_action :find_category, :check_root_category, only: %i(destroy edit update)

    def index
      @categories = Category.all.paginate page: params[:page],
        per_page: Settings.admin.categories.number_of_categories
      respond_to do |format|
        format.html
        format.js
      end
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new category_params
      if @category.save
        flash[:success] = t ".add_success"
        redirect_to admin_categories_path
      else
        flash.now[:danger] = t ".add_failed"
        render :new
      end
    end

    def edit; end

    def update
      if @category.update_attributes category_params
        flash[:success] = t ".update_success"
        redirect_to admin_categories_path
      else
        flash.now[:danger] = t ".update_failed"
        render :edit
      end
    end

    def destroy
      if @category.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_failed"
      end
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit :name, :parent_id
    end

    def find_category
      @category = Category.find_by id: params[:id]
      return if @category
      flash[:danger] = t "admin.categories.not_found_category"
      redirect_to admin_categories_path
    end

    def check_root_category
      return if
        @category.id != Settings.categories.food_default_id &&
        @category.id != Settings.categories.drink_default_id
      flash[:danger] = t "admin.categories.can_not_delete"
      redirect_to admin_categories_path
    end
  end
end
