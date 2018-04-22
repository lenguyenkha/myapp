class ProductsController < ApplicationController
  before_action :load_product, only: %i(show)

  def show
    @rating = @product.ratings.build unless @rating
    @comment = Comment.new
    @comments = @product.comments.desc_created_at.paginate page: params[:page],
      per_page: Settings.products.number_of_comment
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    @rating = Rating.find_by user_id: current_user.id, product_id: @product.id if current_user
    return if @product
    flash[:danger] = t "products.not_found_product"
    redirect_to root_path
  end
end
