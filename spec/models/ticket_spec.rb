require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:status) }
    it { should have_and_belong_to_many(:users) }

    it 'should validate that :status is unresolved by default' do
      ticket = create(:ticket)
      expect(ticket.status).to eq('unresolved')
    end
  end

  context 'search' do
    let(:ticket1) { create(:ticket, content: 'first ticket.') }
    let(:ticket2) { create(:ticket, content: 'second ticket.') }

    it 'should return all matching records' do
      expect(Ticket.search('ticket', 1)).to match([ticket1, ticket2])
    end

    it 'should return specific matching record' do
      expect(Ticket.search('first', 1)).to match([ticket1])
      expect(Ticket.search('second', 1)).to match([ticket2])
    end
  end
end
