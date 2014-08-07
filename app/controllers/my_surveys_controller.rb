class MySurveysController < ApplicationController
  helper_method :surveys_empty?
  def index
    if current_user
      @surveys = {}
      @surveys[:private] = current_user.surveys.privates.includes(:user)
      @surveys[:public] = current_user.surveys.publics.includes(:user)
    else
      redirect_to '/users/sign_in', notice: 'You need to sign in to watch your survey!'
    end
  end
  def surveys_empty?
    return true if @surveys.nil?
    s = @surveys.inject(0) {|sum,arr| sum + arr[1].size}
    s == 0
  end
end
