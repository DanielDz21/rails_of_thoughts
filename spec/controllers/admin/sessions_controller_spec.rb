require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new

      expect(response).to be_successful
    end

    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:user) { FactoryBot.create(:user, admin: true) }

      before do
        post :create, params: { email: user.email, password: user.password }
      end

      it 'logs in the user' do
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      let(:user) { FactoryBot.create(:user, admin: false) }

      before do
        post :create, params: { email: user.email, password: user.password }
      end

      it 'returns http unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryBot.create(:user, admin: true) }

    before { session[:user_id] = user.id }

    it 'logs out the user' do
      expect(session[:user_id]).to eq(user.id)

      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to root path' do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
