class Admin::UsersController < ApplicationController
  before_action :verify_admin
  load_and_authorize_resource

  def index
    @users = @users.page(params[:page]).per_page(Settings.pagination.per_page)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = I18n.t "admin.users.update.update_success"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.success.destroy_user"
    else
      flash[:danger] = t "flash.fail.destroy_user"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :chatwork_id,
      :password, :password_confirmation, :role
  end
end
