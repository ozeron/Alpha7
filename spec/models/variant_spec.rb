require 'rails_helper'

RSpec.describe Variant, :type => :model do
  it 'has a valid factory' do
    variant = FactoryGirl.build(:variant)
    expect(variant).to be_valid
  end

  it { is_expected.to belong_to(:question) }
end
