module Admin
  class SuggestsController < AdminBaseController
    before_action :find_suggest, only: %i(destroy update)

    def index
      @suggests = Suggest.all.paginate page: params[:page],
        per_page: Settings.admin.suggests.number_of_suggests
      respond_to do |format|
        format.html
        format.js
      end
    end

    def destroy
      if @suggest.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_failed"
      end
      redirect_to admin_suggests_path
    end

    def update
      status = params[:status].to_i
      if (check_status status) && @suggest.update_attribute(:status, status)
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".failed"
      end
      redirect_to admin_suggests_path
    end

    private

    def check_status status
      array = [Settings.suggests.accept_status, Settings.suggests.reject_status]
      true if array.include? status
    end

    def find_suggest
      @suggest = Suggest.find_by id: params[:id]
      return if @suggest
      flash[:danger] = t "error_sign_up"
      redirect_to admin_suggests_path
    end
  end
end
