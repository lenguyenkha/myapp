module ProductsHelper
  def product_rating product
    result = []
    rating = product.average_rating.round
    (Settings.products.star_min..Settings.products.star_max).each do |n|
      class_name = "fa fa-star"
      class_name = "fa fa-star-o" if n > rating
      result << content_tag(:i, "", class: class_name)
    end
    safe_join result
  end

  def active_tab symbol, class_name
    if params[:page]
      symbol == :description ? "" : class_name
    else
      symbol == :description ? class_name : ""
    end
  end
end
