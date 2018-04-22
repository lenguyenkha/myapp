module Admin
  class AdminBaseController < ApplicationController
    include ImportProductsHelper
    before_action :logged_in_user, :admin_user
    layout "application_admin"
  end
end
