require 'rails_helper'

RSpec.describe Question, :type => :model do

  it "has a valid factory" do
    expect(FactoryGirl.build(:question)).to be_valid
  end

  it { is_expected.to belong_to(:survey) }
  it { is_expected.to have_many(:answers) }
  it { is_expected.to have_many(:answers) }

  it "expected to have variants" do
    question = FactoryGirl.build(:question_with_variants)
    expect(question.has_variants?).to eq(true)
  end

  it "expected not to have variants" do
    question = FactoryGirl.build(:question_without_variants)
    expect(question.has_variants?).to eq(false)
  end
end

