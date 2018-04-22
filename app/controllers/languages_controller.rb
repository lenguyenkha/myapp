class LanguagesController < ApplicationController
  before_action :check_language, only: :show

  def show
    I18n.default_locale = @language
    redirect_to root_path
  end

  private

  def check_language
    @language =
      if params[:locale]
        params[:locale]
      else
        :vi
      end
  end
end
