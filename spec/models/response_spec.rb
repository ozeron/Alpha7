require 'rails_helper'

RSpec.describe Response, :type => :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:response)).to be_valid
  end
  it { is_expected.to belong_to(:answerer).class_name(User) }
  it { is_expected.to belong_to(:survey) }
  it { is_expected.to have_many(:answers) }
end
