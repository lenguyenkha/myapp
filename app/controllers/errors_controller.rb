class ErrorsController < ApplicationController
  def show
    @code = code_params
    render status: @code
  end

  private

  def code_params
    params[:code] || 500
  end
end
