module Admin
  class ImportProductsController < AdminBaseController
    def new; end

    def create
      file = open_spreadsheet params[:file]
      if file
        Product.import file
        redirect_to admin_products_path
      else
        flash.now[:danger] = t ".import_failed"
        render :new
      end
    end
  end
end
