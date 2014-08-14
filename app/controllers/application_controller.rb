class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  after_filter :store_location

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied!"
    redirect_to root_url
  end

  def store_location
    session[:unique_previous_url] = session[:previous_url] if session[:unque_previous_url] != session[:previous_url]
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

end
