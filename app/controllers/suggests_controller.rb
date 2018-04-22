class SuggestsController < ApplicationController
  before_action :logged_in_user, only: %i(new)

  def new
    @suggest = Suggest.new
  end

  def create
    @suggest = current_user.suggests.build suggest_params
    if @suggest.save
      flash[:success] = t ".suggest_success"
      redirect_to root_url
    else
      flash[:danger] = t ".suggest_fail"
      render :new
    end
  end

  private

  def suggest_params
    params.require(:suggest).permit :product_name, :category_id, :detail
  end
end
