module FiltersHelper
  def render_alphabet
    result = []
    ("A".."Z").each do |e|
      result << (link_to e, filter_params.merge(alpha: e), class: "btn")
    end
    safe_join result
  end

  def render_rating_search result = []
    (Settings.products.star_min..Settings.products.star_max).each do |e|
      result << (content_tag :li, class: "rating" do
        link_to filter_params.merge(rate: e), method: :get do
          content_tag :label, t(".stars", star: e)
        end
      end)
    end
    safe_join result
  end

  def filter_params
    params.permit :alpha, :name, :category_id, :min_price, :max_price, :rate
  end
end
