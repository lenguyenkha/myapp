class RatingsController < ApplicationController
  before_action :logged_in_user, :find_product, only: %i(create update)
  before_action :load_rating, only: :update

  def new; end

  def create
    @rating = current_user.ratings.build rating_params
    if @product.ratings << @rating
      flash[:success] = t ".rating_success"
    else
      flash[:danger] = t ".rating_faild"
    end
    redirect_to @product
  end

  def update
    if @rating.update_attributes rating_params
      flash[:success] = t ".rating_success"
    else
      flash[:danger] = t ".rating_faild"
    end
    redirect_to @product
  end

  private

  def load_rating
    @rating = Rating.find_by id: params[:id]
    return if @rating
    flash[:danger] = t "ratings.not_found_rating"
    redirect_to root_path
  end

  def find_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "products.not_found_product"
    redirect_to root_path
  end

  def rating_params
    params.require(:rating).permit :rate, :product_id
  end
end
