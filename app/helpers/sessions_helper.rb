module SessionsHelper
  def devise_current_user? user
    user == current_user
  end

  def devise_current_user
   @devise_current_user ||= warden.authenticate(:scope => :user)
  end
end
