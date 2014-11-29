require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:user, name: nil)).not_to be_valid
  end

  it "is invalid without a ic" do
    expect(FactoryGirl.build(:user, ic: nil)).not_to be_valid
  end

  it "is invalid without a email" do
    expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
  end

  it "is invalid without a phone" do
    expect(FactoryGirl.build(:user, phone: nil)).not_to be_valid
  end

  it "is invalid without a password" do
    expect(FactoryGirl.build(:user, password: nil)).not_to be_valid
  end
end