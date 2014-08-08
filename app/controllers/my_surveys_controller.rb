class MySurveysController < ApplicationController
  def index
    if current_user
      @surveys = {}
      @surveys[:private] = current_user.surveys.privates.includes(:user)
      @surveys[:public] = current_user.surveys.publics.includes(:user)
    else
      redirect_to :new_user_session, notice: 'You need to sign in to watch your surveys!'
    end
  end
end
