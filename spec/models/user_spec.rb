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
  context "on update" do
    it { should validate_presence_of(:name).on(:update) }
    it { should validate_presence_of(:phone).on(:update) }
    it { should validate_presence_of(:ic).on(:update) }
    it { should allow_value(subject.ic)
                    .for(:ic)
                    .on(:update) }
    it { should validate_uniqueness_of(:ic).on(:update) }
  end

  # Relationships
  it { should have_and_belong_to_many(:roles) }

  describe "#add_role" do
    it 'returns true if added' do
      # exercise and verify
      expect(subject.add_role(role.name)).to be_truthy
    end

    it 'returns false if !added' do
      # exercise and verify
      expect(subject.add_role(nil)).to be_falsey
    end
  end

  describe "#has_role?" do
    it 'returns true if exists' do
      # setup
      subject.roles.push(Role.find_by_name(role.name))

      # exercise and verify
      expect(subject.has_role?(role.name)).to be_truthy
    end

    it 'returns false if !exists' do
      expect(subject.has_role?(nil)).to be_falsey
    end
  end

  describe "#delete_role" do
    it 'returns true deleted' do
      # setup
      subject.roles.push(Role.find_by_name(role.name))

      # exercise and verify
      expect(subject.delete_role(role.name)).to be_truthy
    end

    it 'returns false if !deleted' do
      # exercise and verify
      expect(subject.delete_role(nil)).to be_falsey
    end
  end

  describe "#list_roles" do
    it 'returns a list of roles' do
      # setup
      subject.roles.push(Role.find_by_name(role.name))

      # exercise and verify
      expect(subject.list_roles).to include role.name
    end
  end
end