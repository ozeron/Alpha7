class SharingController < ApplicationController

  def create
    survey = Survey.find(params[:id])

    authorize! :share, survey if survey.private?

    sh = SharedLink.create(survey: survey)
    @url_txt = request.original_url.split("?")[0] + "/#sh.key"
  end

  def show
    shared_link = SharedLink.where(key: params[:id]).first
    if shared_link
      @survey = shared_link.survey
      render "surveys/show"
    else
      redirect_to root_path, notice: 'Survey not found!'
    end
  end
end
