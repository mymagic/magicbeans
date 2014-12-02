require 'rails_helper'

RSpec.describe Program, :type => :model do
  let(:subject) { create :program }

  describe 'factory' do
    it "has a valid factory" do
      expect(subject).to be_valid
    end
  end

  describe 'responses' do
    it { is_expected.to respond_to :name, :description, :speaker, :speakerbio, :biourl, :keytakeways, :tags, :resources }
  end

  describe 'relationship' do
    it { should have_many(:activities) }
  end

  describe 'accepts attributes' do
    it { should accept_nested_attributes_for(:activities).allow_destroy(true) }
  end
end