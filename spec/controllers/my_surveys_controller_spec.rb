require 'rails_helper'

RSpec.describe MySurveysController, :type => :controller do
  context "autorized user" do
    let(:user) {FactoryGirl.create(:user)}
    subject {FactoryGirl.create(:survey, user: user)}
    before do
      sign_in user
    end
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to render_template :index
      end
      it "assigns the requested surveys to the subject" do
        get :index
        expect(assigns(:surveys)[:public]).to eq([subject])
      end
    end
  end

  context "unautorized user" do
    describe "should redirect to user/sign_in" do
      it "renders the :sign_in view" do
        get :index
	expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

end
