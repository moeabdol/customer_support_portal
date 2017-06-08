require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:role) }
    it { should have_and_belong_to_many(:tickets) }

    it 'should validate that :role is customer by default' do
      user = create(:user)
      expect(user.role).to eq('customer')
    end
  end

  context 'roles' do
    it 'should return true if user is admin' do
      user = create(:user, role: 'admin')
      expect(user.admin?).to be_truthy
    end

    it 'should return false if user is not admin' do
      user = create(:user, role: 'customer')
      expect(user.admin?).to be(false)
    end

    it 'should return true if user is agent' do
      user = create(:user, role: 'agent')
      expect(user.agent?).to be_truthy
    end

    it 'should return false if user is not agent' do
      user = create(:user, role: 'customer')
      expect(user.agent?).to be(false)
    end

    it 'should return true if user is customer' do
      user = create(:user, role: 'customer')
      expect(user.customer?).to be_truthy
    end

    it 'should return false if user is not customer' do
      user = create(:user, role: 'admin')
      expect(user.customer?).to be(false)
    end
  end
end
