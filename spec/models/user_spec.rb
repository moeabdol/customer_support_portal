require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:role) }

    it 'should validate that :role is customer by default' do
      user = create(:user)
      expect(user.role).to eq('customer')
    end
  end
end
