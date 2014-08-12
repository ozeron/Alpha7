require 'rails_helper'

RSpec.describe Answer, :type => :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:answer)).to be_valid
  end

  it { is_expected.to belong_to(:question) }
  it { is_expected.to belong_to(:response) }

end
