class SurveysController < ApplicationController

  load_resource  only: [:edit, :update, :destroy, :submit]
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
    @survey = Survey.where(id: params[:id]).includes(:questions).first
    @survey.questions.each do |question|
      1.times { question.answers.build}
    end
  end

  def new
    if current_user
      @survey = Survey.new
    else
      redirect_to :new_user_session, notice: 'You need to sign in to create a survey!'
    end
  end

  def create
    @survey = current_user.surveys.new(survey_params)
    if @survey.save
      redirect_to my_surveys_path
    else
      render :new
    end
  end

  def update
    if @survey.update(survey_params)
      redirect_to my_surveys_path, notice: 'Edited survey!'
    else
      render :edit
    end
  end

  def submit
    @answer = Answer.create(answer_params)
    if @answer.save
      redirect_to root_path, notice: "Thank you for your answer! Take One more Survey!"
    else
      redirect_to session[:previous_url], notice: "Something goes wrong, try again!"
    end
  end

  def destroy
    @survey.destroy
    redirect_to my_surveys_path, notice: 'Deleted survey!'
  end

  # def find_survey
  #   @survey = Survey.find[params[:id]]
  # end

  private

  def survey_params
    params.require(:survey).permit!
  end

  def answer_params
    [:id, :text, :_destroy].permit!
  end

  def question_params
    [:id, :text, :kind, :_destroy]
  end

  def variant_params
    [:id, :text, :_destroy]
  end
end
