require 'rails_helper'

RSpec.describe Survey, :type => :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:survey)).to be_valid
  end
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to belong_to(:user).class_name(User) }
  it { is_expected.to have_many(:questions) }
  it { is_expected.to have_many(:responses) }
  it { is_expected.to have_many(:answers) }
end
