require 'rails_helper'

RSpec.describe User, :type => :model do
  it{is_expected.to respond_to :name, :ic, :phone}
  let(:subject) { create :user }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  context 'when updating' do
    it "should have a name" do
      expect(create :user, name: nil).not_to be_valid
    end

    it "should have an ic" do
      expect(create :user, ic: nil ).not_to be_valid
    end

    it "should have a phone" do
      expect(create :user, phone: nil).not_to be_valid
    end

    it "should have a unique ic" do
      expect(build :user, ic: subject.ic).not_to be_valid
    end

    it "should have a valid ic" do
      expect(subject.ic).to match /\A\d{6}-\d{2}-\d{4}\z/
    end
  end
end