class SurveysController < ApplicationController

  load_resource  only: [:edit, :update, :destroy, :submit]
  authorize_resource

  def index
    if params[:query].present?
      @surveys = Survey.order(updated_at: :desc).search(params[:query], page: params[:page], fields: [ { title: :word_start } ])
    else
      @surveys = Survey.publics.order(updated_at: :desc).page(params[:page]).per_page(10).includes(:user)
    end
    if @surveys.empty?
      flash.now[:notice] = "No survey found!"
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
      flash[:success] = 'Survey was successfully created.'
      redirect_to default_path
    else
      flash[:error] = 'Survey should have Title and at least one question.'
      render :new
    end
  end

  def update
    if @survey.update(survey_params)
      flash[:success] = 'Survey was successfully created.'
      redirect_to default_path, notice: 'Edited survey!'
    else
      flash[:error] = 'Survey should have Title and at least one question.'
      render :edit
    end
  end

  def destroy
    @survey.destroy
    redirect_to default_path, notice: 'Deleted survey!'
  end

  def submit
    data = params.require(:survey).require(:answers).permit!
    if data
      response = Response.create(survey: @survey, answerer: current_user)
      data.each_with_index do |data,index|
        id = data.first.to_i
        text = data.last
        answer = response.answers.build(question: @survey.questions[id], text: text)
        if answer.valid?
          answer.save!
        else
          flash[:notice] = "Answer" + answer.errors.full_messages.first
          render :show
          response.destroy
          return
        end
      end
      redirect_to root_path, notice: "Thank you for your answer! Take One more Survey!"
    else
      redirect_to session[:previous_url], notice: "Something goes wrong, try again!"
    end
  end

  def result
    @survey = Survey.where(id: params[:id]).includes(responses: :answers).first
    authorize! :result, @survey
  end


  # def find_survey
  #   @survey = Survey.find[params[:id]]
  # end

  private
  def default_path
    session[:unique_previous_url] || my_surveys_path
  end
  def survey_params
    params.require(:survey).permit!
    #TODO
    #Permit. :title, questions_attributes: question_params
  end

  def answer_params
    params.require(:survey).permit!
  end

  def question_params
    [:id, :text, :kind, :_destroy]
  end

  def variant_params
    [:id, :text, :_destroy]
  end
end
