require 'rails_helper'

RSpec.describe SurveysController, :type => :controller do

  context "autorized user " do
    let(:user) {FactoryGirl.create(:user)}
    subject {FactoryGirl.create(:survey, user: user)}

    before do
      sign_in user
    end

    describe "GET #index" do
      it "render :index view" do
        get :index
        expect(response).to render_template :index
      end
      it "assigns the requested surveys to the subject" do
        get :index
        expect(assigns(:surveys)).to eq([subject])
      end
    end

    describe "GET #show" do
      it "assigns the requested survey to the subject" do
        get :show, id:subject
        expect(assigns(:survey)).to eq(subject)
      end
      it "renders the :show view" do
        get :show, id: subject
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "assigns the requested survey to the subject" do
        get :new
        expect(assigns(:survey)).to be_new_record
      end
      it "renders the :new view" do
        get :new, id: subject.id
        expect(response).to render_template :new
      end
    end

    describe "create with valid attributes" do
      it "creates new object" do
        expect {
          post :create, survey: FactoryGirl.attributes_for(:survey, user: :user)
        }. to change(Survey, :count ).by( 1)
      end
      it "redirects to surveys path" do
        post :create, survey: FactoryGirl.attributes_for(:survey, user: :user)
        expect(response).to redirect_to my_surveys_path
      end
    end

    describe "GET #edit" do
      it "assigns the requested survey to subject" do
        get :edit, id: subject
        expect(assigns(:survey)).to eq(subject)
      end
      it "renders the :edit view" do
        get :edit, id: subject
        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates object" do
          expect {
            patch :update, id: subject, survey: {title: 'Best Survey'}
          }.to change{ subject.reload.title }.to('Best Survey')
        end
        it "redirects to index path" do
          patch :update, id:subject , survey: {title: 'Best Survey' }
          expect(response).to redirect_to my_surveys_path
        end
      end
    end
    describe "DELETE #destroy" do
      before(:each) {@survey = FactoryGirl.create :survey, user: user}

      it  "deletes the survey" do
        expect {
          delete :destroy, id: @survey
        }.to change(Survey, :count).by(-1)
      end
      it "redirects to survey#index" do
       delete :destroy, id: @survey
       expect(response).to redirect_to my_surveys_path
      end
    end
    describe "GET #results" do
      it "assigns the requested survey to the subject" do
        get :result, id:subject
        expect(assigns(:survey)).to eq(subject)
      end
      it "renders the :result view" do
        get :result, id: subject
        expect(response).to render_template :result
      end
    end

  end

  context "unautorized user" do
    let(:user) {FactoryGirl.create(:user)}
    subject {FactoryGirl.create(:survey, user: user)}
    describe "should redirect to user/sign_in" do
      it "new renders the :sign_in view" do
        get :new, id: subject
        expect(response).to redirect_to '/users/sign_in'
      end
      it "result renders the :sign_in view" do
        get :result, id: subject
        expect(response).to redirect_to '/'
      end
    end
  end
end
