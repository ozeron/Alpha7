class SurveysController < ApplicationController

  load_resource  only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    if params[:query].present?
      @surveys = Survey.search(params[:query], page: params[:page])
    else
      @surveys = Survey.where(private: false).page(params[:page]).per_page(10).includes(:user)
    end
  end

  def show
  end

  def new
    if current_user
      @survey = Survey.new
    else
      redirect_to '/users/sign_in', notice: 'You need to sign in to create a survey!'
    end
  end
  
  def create
    @survey = current_user.surveys.new( survey_params)
    if @survey.save
      redirect_to surveys_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @survey.update(survey_params)
      redirect_to surveys_path, notice: 'Edited survey!'
    else
      render :edit
    end
  end
  
  def destroy
    @survey.destroy
    redirect_to surveys_path, notice: 'Deleted survey!'
  end
  
  private

  def survey_params
    params.require(:survey).permit(:title)
  end

end
