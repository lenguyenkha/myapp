module Admin
  class UsersController < AdminBaseController
    before_action :find_user, only: %i(destroy)

    def index
      @users =
        if params[:search]
          User.search(params[:search]).paginate page: params[:page],
            per_page: Settings.admin.users.number_of_users
        else
          User.all.paginate page: params[:page],
            per_page: Settings.admin.users.number_of_users
        end
      respond_to do |format|
        format.html
        format.js
      end
    end

    def destroy
      if !@user.is_admin? && @user.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_failed"
      end
      redirect_to admin_users_path
    end

    private

    def find_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:danger] = t "error_sign_up"
      redirect_to admin_users_path
    end
  end
end
