require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, role: 'admin') }
  let(:agent) { create(:user, role: 'agent') }
  let(:customer) { create(:user, role: 'customer') }

  describe "GET #index" do
    before(:example) do
      sign_in(admin)
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @users' do
      expect(assigns(:users)).to contain_exactly(user, admin, agent, customer)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #agents" do
    before(:example) do
      sign_in(admin)
      get :agents
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @users' do
      expect(assigns(:users)).to contain_exactly(agent)
    end

    it 'renders agents template' do
      expect(response).to render_template(:agents)
    end
  end

  describe "GET #customers" do
    before(:example) do
      sign_in(agent)
      get :customers
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @users' do
      expect(assigns(:users)).to contain_exactly(user, customer)
    end

    it 'renders customers template' do
      expect(response).to render_template(:customers)
    end
  end

  describe 'GET #show' do
    before(:example) do
      sign_in(user)
      get :show, params: { id: user }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns @tickets' do
      ticket = create(:ticket)
      user.tickets << ticket
      expect(assigns(:tickets)).to eq(user.tickets)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    before(:example) do
      sign_in(admin)
      get :edit, params: { id: customer }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @user' do
      expect(assigns(:user)).to eq(customer)
    end

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before(:example) do
        sign_in(admin)
        patch :update, params: {
          id: customer,
          user: attributes_for(:user)
        }
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'assigns @user' do
        expect(assigns(:user)).to eq(customer)
      end

      it 'redirects to show page' do
        expect(response).to redirect_to(customer)
      end
    end

    context 'with invalid attributes' do
      before(:example) do
        sign_in(admin)
        patch :update, params: {
          id: customer,
          user: attributes_for(:user, email: nil)
        }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns @user' do
        expect(assigns(:user)).to eq(customer)
      end

      it 'renders edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:example) do
      sign_in(admin)
      delete :destroy, params: { id: customer }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'assigns @user' do
      expect(assigns(:user)).to eq(customer)
    end

    it 'redirects to index page' do
      expect(response).to redirect_to(users_path)
    end
  end
end
