require 'rails_helper'

describe TicketPolicy do
  subject { described_class }

  context 'admin' do
    let(:admin) { create(:user, role: 'admin') }
    let(:ticket) { create(:ticket) }

    permissions :index? do
      it 'grants access' do
        expect(subject).to permit(admin)
      end
    end

    permissions :show? do
      it 'grants access' do
        expect(subject).to permit(admin, ticket)
      end
    end

    permissions :new?, :create?, :resolve? do
      it 'denies access' do
        expect(subject).not_to permit(admin)
      end
    end

    permissions :edit?, :update?, :destroy? do
      it 'grants access' do
        expect(subject).to permit(admin, ticket)
      end
    end
  end

  context 'agent' do
    let(:agent) { create(:user, role: 'agent') }
    let(:ticket) { create(:ticket) }

    permissions :index? do
      it 'grants access' do
        expect(subject).to permit(agent)
      end
    end

    permissions :new?, :create?, :edit?, :update?, :destroy? do
      it 'denies access' do
        expect(subject).not_to permit(agent)
      end
    end

    permissions :show? do
      it 'grants access' do
        expect(subject).to permit(agent, ticket)
      end
    end

    permissions :resolve? do
      it 'grants access if ticket is unresolved' do
        expect(subject).to permit(agent, ticket)
      end

      it 'denies access if ticket is resolved' do
        resolved_ticket = create(:ticket, status: 'resolved')
        expect(subject).not_to permit(agent, resolved_ticket)
      end
    end
  end

  context 'customer' do
    let(:customer) { create(:user, role: 'customer') }
    let(:ticket) { create(:ticket) }

    permissions :index? do
      it 'denies access' do
        expect(subject).not_to permit(customer)
      end
    end

    permissions :new?, :create? do
      it 'grants access' do
        expect(subject).to permit(customer)
      end
    end

    permissions :show? do
      it 'grants access if customer owns ticket' do
        customer.tickets << ticket
        expect(subject).to permit(customer, ticket)
      end

      it 'denies access if customer does not own ticket' do
        expect(subject).not_to permit(customer, ticket)
      end
    end

    permissions :edit?, :update?, :destroy? do
      it 'grants access if customer owns ticket and ticket is unresolved' do
        customer.tickets << ticket
        expect(subject).to permit(customer, ticket)
      end

      it 'denis access if customer does not own ticket' do
        expect(subject).not_to permit(customer, ticket)
      end

      it 'denis access if ticket is resolved' do
        resolved_ticket = create(:ticket, status: 'resolved')
        customer.tickets << resolved_ticket
        expect(subject).not_to permit(customer, resolved_ticket)
      end
    end

    permissions :resolve? do
      it 'denies access' do
        expect(subject).not_to permit(customer, ticket)
      end
    end
  end
end
