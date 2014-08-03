class ProfilesController < Devise::RegistrationsController

  private
 
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
 
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :gender, :birthday, :avatar, :avatar_cache, :remove_avatar)
  end

end
