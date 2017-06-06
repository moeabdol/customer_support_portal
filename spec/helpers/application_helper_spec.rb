require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'returns active if current page match name' do
    allow(self).to receive(:current_page?).and_return(true)
    expect(active_class('/')).to match('active')
  end

  it 'returns active if current controller match name' do
    allow(controller_name).to receive(:eql?).and_return(true)
    expect(active_class('tickets')).to match('active')
  end

  it 'returns empty string if current page does not match name' do
    allow(self).to receive(:current_page?).and_return(false)
    expect(active_class('/')).to match('')
  end

  it 'returns empty string if current controller does not match name' do
    allow(self).to receive(:current_page?).and_return(false)
    allow(controller_name).to receive(:eql?).and_return(false)
    expect(active_class('tickets')).to match('')
  end

  it 'returns success if ticket is resolved' do
    ticket = create(:ticket, status: 'resolved')
    expect(ticket_status_class(ticket)).to match('success')
  end

  it 'returns danger if ticked is unresolved' do
    ticket = create(:ticket, status: 'unresolved')
    expect(ticket_status_class(ticket)).to match('danger')
  end
end
