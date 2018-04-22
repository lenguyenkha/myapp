class StaticPagesController < ApplicationController
  def home
    @food = Category.find_by id: Settings.categories.food_default_id
    @drink = Category.find_by id: Settings.categories.drink_default_id
    @food_product = find_product @food, params[:page_food]
    @drink_product = find_product @drink, params[:page_drink]
    @hot_trend = Product.hot_trend.paginate page: params[:page_hot_trend],
      per_page: Settings.home.number_of_products
    respond_to do |format|
      format.html
      format.js
    end
  end
end
