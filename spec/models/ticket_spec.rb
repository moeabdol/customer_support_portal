require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { expect validate_presence_of(:content) }
  it { expect validate_presence_of(:status) }

  it 'should default status to unresolved' do
    ticket = create(:ticket)
    expect(ticket.status).to eq('unresolved')
  end
end
