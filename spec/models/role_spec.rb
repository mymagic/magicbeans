require 'rails_helper'

RSpec.describe Role, :type => :model do
  let(:subject) { create :role }

  describe 'factory' do
    it "has a valid factory" do
      expect(subject).to be_valid
    end
  end

  describe 'responses' do
    it { is_expected.to respond_to :name}
  end

  describe 'relationship' do
    it { should have_and_belong_to_many(:users) }
  end
end