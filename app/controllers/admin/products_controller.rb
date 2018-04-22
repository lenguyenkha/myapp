module Admin
  class ProductsController < AdminBaseController
    before_action :find_product, only: %i(destroy edit update)

    def index
      @products = Product.all.paginate page: params[:page],
        per_page: Settings.admin.products.number_of_products
      respond_to do |format|
        format.html
        format.js
      end
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new product_params
      if @product.save
        flash[:success] = t ".add_success"
        redirect_to admin_products_path
      else
        flash.now[:danger] = t ".add_failed"
        render :new
      end
    end

    def edit; end

    def update
      if @product.update_attributes product_params
        flash[:success] = t ".update_success"
        redirect_to admin_products_path
      else
        flash.now[:danger] = t ".update_failed"
        render :edit
      end
    end

    def destroy
      if @product.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_failed"
      end
      redirect_to admin_products_path
    end

    private

    def product_params
      params.require(:product).permit :name, :detail, :price, :quantity, :category_id, :picture
    end

    def find_product
      @product = Product.find_by id: params[:id]
      return if @product
      flash[:danger] = t "admin.products.not_found_product"
      redirect_to admin_products_path
    end
  end
end
