require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    before(:example) { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end
end
