require 'rails_helper'

RSpec.describe User, :type => :model do
  # Setup
  let(:subject) { create :user }
  let(:role) { create :role}

  # Factory
  it "has a valid factory" do
    expect(subject).to be_valid
  end

  # Responses
  it { is_expected.to respond_to :name, :ic, :phone }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:ic) }
  it { should allow_value(subject.ic)
                  .for(:ic)
                  .on(:update)
                  .with_message('Invalid IC Format') }
  it "validates uniqueness of ic" do
      expect(build :user, ic: subject.ic).not_to be_valid
  end

  # Relationships
  it { should have_and_belong_to_many(:roles) }

  describe "#has_role?" do
    it { is_expected.to respond_to :has_role? }
    it 'returns true if role exists' do
      # setup
      subject.roles.push(Role.find_by_name(role.name))

      # exercise and verify
      expect(subject.roles.include?(Role.find_by_name(role.name))).to be_truthy
    end
  end

  describe "#add_role" do
    it { is_expected.to respond_to :add_role }
    it 'returns true if role is added' do
      # exercise and verify
      expect(subject.roles.push(Role.find_by_name(role.name))).to be_truthy
    end
  end

  describe "#delete_role" do
    it { is_expected.to respond_to :delete_role }
    it 'returns true if role is deleted' do
      # setup
      subject.roles.push(Role.find_by_name(role.name))

      # exercise and verify
      expect(subject.roles.delete(Role.find_by_name(role.name))).to be_truthy
    end
  end

  describe "#list_roles" do
    it { is_expected.to respond_to :list_roles }
    it 'returns a list of roles' do
      # setup
      subject.roles.push(Role.find_by_name(role.name))

      # exercise and verify
      expect(subject.roles.map(&:name)).to eq ["Admin"]
    end
  end
end