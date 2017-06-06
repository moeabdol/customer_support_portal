require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:status) }

    it 'should validate that :status is unresolved by default' do
      ticket = create(:ticket)
      expect(ticket.status).to eq('unresolved')
    end
  end
end
