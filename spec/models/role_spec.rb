require 'rails_helper'

RSpec.describe Role, :type => :model do
  it{is_expected.to respond_to :name}

  let(:role) { create :role }
  let(:user) { create :user }

  it "has many users" do
    role.users << user
    expect(role.users.any?).to be_truthy
  end

  it "belongs to many users" do
    user.roles << role
    expect(user.roles.any?).to be_truthy
  end
end