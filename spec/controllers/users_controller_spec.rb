require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, role: 'admin') }
  let(:agent) { create(:user, role: 'agent') }
  let(:customer) { create(:user, role: 'customer') }

  describe "GET #index without passing page param" do
    before(:example) do
      sign_in(user)
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @users' do
      expect(assigns(:users)).to contain_exactly(user, admin, agent, customer)
    end

    it 'assigns @page' do
      expect(assigns(:page)).to eq(nil)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #index with page param = agents" do
    before(:example) do
      sign_in(admin)
      get :index, params: { page: 'agents' }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @users' do
      expect(assigns(:users)).to contain_exactly(agent)
    end

    it 'assigns @page' do
      expect(assigns(:page)).to match('agents')
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #index with page param = customers" do
    before(:example) do
      sign_in(agent)
      get :index, params: { page: 'customers' }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @users' do
      expect(assigns(:users)).to contain_exactly(user, customer)
    end

    it 'assigns @page' do
      expect(assigns(:page)).to match('customers')
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
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

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end
end
