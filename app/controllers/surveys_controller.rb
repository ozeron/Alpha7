class SurveysController < ApplicationController

  load_resource  only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    if params[:query].present?
      @surveys = Survey.search(params[:query], page: params[:page], fields: [ { title: :word_start } ])
    else
      @surveys = Survey.publics.page(params[:page]).per_page(10).includes(:user)
    end
    if @surveys.empty?
      flash.now[:notice] = "No match found!"
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
