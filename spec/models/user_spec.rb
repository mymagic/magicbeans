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
  describe 'responses' do
    it { is_expected.to respond_to :name, :ic, :phone }
  end

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

  context "on create" do
    it { should_not validate_presence_of(:name).on(:create) }
    it { should_not validate_presence_of(:phone).on(:create) }
    it { should_not validate_presence_of(:ic).on(:create) }
  end

  describe 'relationship' do
    it { should have_and_belong_to_many(:roles) }
  end

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

  context "has a role" do
    before (:each) do
      subject.roles.push(Role.find_by_name(role.name))
    end

    describe "#has_role?" do
      it 'returns true if exists' do
        # exercise and verify
        expect(subject.has_role?(role.name)).to be_truthy
      end

      it 'returns false if !exists' do
        expect(subject.has_role?(nil)).to be_falsey
      end
    end

    describe "#delete_role" do
      it 'returns true deleted' do
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
        # exercise and verify
        expect(subject.list_roles).to include role.name
      end
    end
  end
end