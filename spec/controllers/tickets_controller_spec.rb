require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe "GET #index" do
    before(:example) do
      sign_in(create(:user, role: 'admin'))
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @tickets' do
      expect(assigns(:tickets)).to eq([])
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    before(:example) do
      sign_in(create(:user, role: 'customer'))
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @ticket' do
      expect(assigns(:ticket)).to be_a_new(Ticket)
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before(:example) do
        sign_in(create(:user, role: 'customer'))
        post :create, params: { ticket: attributes_for(:ticket) }
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'assigns @ticket' do
        expect(assigns(:ticket)).to be_present
      end

      it 'redirects to show page' do
        ticket = assigns(:ticket)
        expect(response).to redirect_to(ticket)
      end
    end

    context 'with invalid attributes' do
      before(:example) do
        sign_in(create(:user, role: 'customer'))
        post :create, params: { ticket: attributes_for(:ticket, content: nil) }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns @ticket' do
        expect(assigns(:ticket)).to be_present
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    let(:ticket) { create(:ticket) }
    before(:example) do
      sign_in(create(:user, role: 'admin'))
      get :show, params: { id: ticket }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @ticket' do
      expect(assigns(:ticket)).to eq(ticket)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    let(:ticket) { create(:ticket) }
    before(:example) do
      customer = create(:user, role: 'customer')
      customer.tickets << ticket
      sign_in(customer)
      get :edit, params: { id: ticket }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @ticket' do
      expect(assigns(:ticket)).to eq(ticket)
    end

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:ticket) { create(:ticket) }
      before(:example) do
        customer = create(:user, role: 'customer')
        customer.tickets << ticket
        sign_in(customer)
        patch :update, params: {
          id: ticket,
          ticket: attributes_for(:ticket, status: 'resolved')
        }
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'assigns @ticket' do
        expect(assigns(:ticket)).to eq(ticket)
      end

      it 'redirects to show page' do
        expect(response).to redirect_to(ticket)
      end
    end

    context 'with invalid attributes' do
      let(:ticket) { create(:ticket) }
      before(:example) do
        customer = create(:user, role: 'customer')
        customer.tickets << ticket
        sign_in(customer)
        patch :update, params: {
          id: ticket,
          ticket: attributes_for(:ticket, status: nil)
        }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns @ticket' do
        expect(assigns(:ticket)).to eq(ticket)
      end

      it 'renders edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:ticket) { create(:ticket) }
    before(:example) do
      customer = create(:user, role: 'customer')
      customer.tickets << ticket
      sign_in(customer)
      delete :destroy, params: { id: ticket }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'assigns @ticket' do
      expect(assigns(:ticket)).to eq(ticket)
    end

    it 'redirects to index page' do
      expect(response).to redirect_to(tickets_path)
    end
  end

  describe 'GET #resolve' do
    let(:ticket) { create(:ticket, status: 'unresolved') }
    before(:example) do
      agent = create(:user, role: 'agent')
      sign_in(agent)
      get :resolve, params: { id: ticket }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'assigns @ticket' do
      expect(assigns(:ticket)).to eq(ticket)
    end

    it 'redirects to show page' do
      expect(response).to redirect_to(ticket)
    end
  end
end
