require 'rails_helper'

RSpec.describe User, :type => :model do

  it "user has a valid factory" do
    expect( FactoryGirl.build(:user)).to be_valid
  end

  it "admin has a valid factory" do
    expect( FactoryGirl.build(:user)).to be_valid
  end

  it { is_expected.to have_many(:surveys) }
  it { is_expected.to have_many(:responses) }

  it { is_expected.to allow_value("Alexander").for(:first_name) }
  it { is_expected.to allow_value("Polovniko'v").for(:last_name) }
  it { is_expected.to allow_value("1988-24-06").for(:birthday) }

end
