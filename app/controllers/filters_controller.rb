class FiltersController < ApplicationController
  def show
    @title = t ".all_product"
    @root_categories = Category.root_categories
    @products = Product.filter_product(params).paginate page: params[:page],
      per_page: Settings.filters.number_of_products
    respond_to do |format|
      format.html
      format.json{render json: @products}
      format.js
    end
  end

  def new; end
end
