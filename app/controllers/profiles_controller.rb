class ProfilesController < Devise::RegistrationsController

  def update
    @user = User.find(current_user.id)

    successfully_updated = if @user.needs_password?(@user, params)
      @user.update_with_password(account_update_params)
    else
      params[:user].delete(:current_password)
      @user.update_without_password(account_update_params)

    end

    if successfully_updated
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def generate_new_password_email
    user = User.find(params[:user_id])
    user.send_reset_password_instructions
    flash[:notice] = "reset send"
    redirect_to root_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :gender, :birthday, :avatar, :avatar_cache, :remove_avatar, :valid_date?)
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end


end
