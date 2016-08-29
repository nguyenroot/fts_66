class Admin::UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]

  def index
    @users = User.page(params[:page]).per(Settings.pagination.per_page)
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
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = I18n.t "users.not_found"
      redirect_to admin_users_path
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :chatwork_id,
      :password, :password_confirmation, :role
  end
end
