require 'rails_helper'

describe UserPolicy do
  subject { described_class }

  context 'admin' do
    let(:admin) { create(:user, role: 'admin') }
    let(:agent) { create(:agent) }
    let(:customer) { create(:customer) }

    permissions :index?, :agents?, :customers? do
      it 'grants access' do
        expect(subject).to permit(admin)
      end
    end

    permissions :show? do
      it 'grants access to own profile' do
        expect(subject).to permit(admin)
      end

      it 'grants access to agent profile' do
        expect(subject).to permit(admin, agent)
      end

      it 'grants access to customer profile' do
        expect(subject).to permit(admin, customer)
      end
    end
  end

  context 'agent' do
    let(:agent1) { create(:user, role: 'agent') }
    let(:agent2) { create(:user, role: 'agent') }
    let(:customer) { create(:user, role: 'customer') }
    let(:admin) { create(:user, role: 'admin') }

    permissions :index? do
      it 'denies access' do
        expect(subject).not_to permit(agent1)
      end
    end

    permissions :show? do
      it 'grants access to own profile' do
        expect(subject).to permit(agent1, agent1)
      end

      it 'grants access to customer profile' do
        expect(subject).to permit(agent1, customer)
      end

      it 'denies access to admin profile' do
        expect(subject).not_to permit(agent1, admin)
      end

      it 'denies access to other agent profile' do
        expect(subject).not_to permit(agent1, agent2)
      end
    end

    permissions :agents? do
      it 'denies access' do
        expect(subject).not_to permit(agent1)
      end
    end

    permissions :customers? do
      it 'grants access' do
        expect(subject).to permit(agent1)
      end
    end
  end

  context 'customer' do
    let(:customer1) { create(:user, role: 'customer') }
    let(:customer2) { create(:user, role: 'customer') }
    let(:agent) { create(:user, role: 'agent') }
    let(:admin) { create(:user, role: 'admin') }

    permissions :index?, :agents?, :customers? do
      it 'denies access' do
        expect(subject).not_to permit(customer1)
      end
    end

    permissions :show? do
      it 'grants access to own profile' do
        expect(subject).to permit(customer1, customer1)
      end

      it 'denies access to other customer profile' do
        expect(subject).not_to permit(customer1, customer2)
      end

      it 'denies access to agent profile' do
        expect(subject).not_to permit(customer1, agent)
      end

      it 'denies access to admin profile' do
        expect(subject).not_to permit(customer1, admin)
      end
    end
  end
end
