require 'rails_helper'

RSpec.describe User, :type => :model do
  it{is_expected.to respond_to :name, :ic, :phone}

  let(:user) { create :user }
  let(:role) { create :role }

  it "has a valid factory" do
    expect(user).to be_valid
  end

  context 'when updating' do
    it "should have a name" do
      expect(user.update(name: nil)).to be_falsey
    end

    it "should have a phone" do
      expect(user.update(phone: nil)).to be_falsey
    end

    it "should have an ic" do
      expect(user.update(ic: nil)).to be_falsey
    end

    it "should have a valid ic" do
      expect(user.ic).to match /\A\d{6}-\d{2}-\d{4}\z/
    end

    it "should have a unique ic" do
      expect(build :user, ic: user.ic).not_to be_valid
    end
  end

  it "has many roles" do
    user.roles << role
    expect(user.roles.any?).to be_truthy
  end

  it "belongs to many roles" do
    role.users << user
    expect(role.users.any?).to be_truthy
  end
end