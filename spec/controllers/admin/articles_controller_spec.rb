require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do
  let(:user) { FactoryBot.create(:user, admin: true) }
  let(:login) { session[:user_id] = user.id }

  describe 'before_action :authenticate_user!' do
    it 'redirects to login page when user is not authenticated' do
      get :index
      expect(response).to redirect_to(new_admin_sessions_path)
    end

    it 'does not redirect when user is authenticated' do
      login
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #index' do
    it 'returns all articles' do
      login
      articles = FactoryBot.create_list(:article, 2)
      get :index

      expect(assigns(:articles)).to eq(articles)
    end
  end

  describe 'GET #show' do
    it 'returns the requested article' do
      login
      article = FactoryBot.create(:article)
      get :show, params: { id: article.id }
      expect(assigns(:article)).to eq(article)
    end
  end

  describe 'GET #new' do
    it 'returns a new article' do
      login
      get :new
      expect(assigns(:article)).to be_a_new(Article)
    end
  end

  describe 'GET #edit' do
    it 'returns the requested article' do
      login
      article = FactoryBot.create(:article)
      get :edit, params: { id: article.id }
      expect(assigns(:article)).to eq(article)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new article' do
        login
        expect do
          post :create, params: { article: FactoryBot.attributes_for(:article) }
        end.to change(Article, :count).by(1)
      end

      it 'redirects to the created article' do
        login
        post :create, params: { article: FactoryBot.attributes_for(:article) }
        expect(response).to redirect_to([:admin, Article.last])
      end
    end

    context 'with invalid params' do
      it 'does not create a new article' do
        login
        expect do
          post :create, params: { article: FactoryBot.attributes_for(:article, title: nil) }
        end.to_not change(Article, :count)
      end

      it 'renders the new template' do
        login
        post :create, params: { article: FactoryBot.attributes_for(:article, title: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let(:article) { FactoryBot.create(:article) }

    context 'with valid params' do
      it 'updates the requested article' do
        login
        patch :update, params: { id: article.id, article: { title: 'New Title' } }
        article.reload
        expect(article.title).to eq('New Title')
      end

      it 'redirects to the article' do
        login
        patch :update, params: { id: article.id, article: { title: 'New Title' } }
        expect(response).to redirect_to([:admin, article])
      end
    end

    context 'with invalid params' do
      it 'does not update the requested article' do
        login
        patch :update, params: { id: article.id, article: { title: nil } }
        article.reload
        expect(article.title).to_not eq(nil)
      end

      it 'renders the edit template' do
        login
        patch :update, params: { id: article.id, article: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:article) { FactoryBot.create(:article) }

    it 'destroys the requested article' do
      login
      article
      expect do
        delete :destroy, params: { id: article.id }
      end.to change(Article, :count).by(-1)
    end

    it 'redirects to the articles list' do
      login
      delete :destroy, params: { id: article.id }
      expect(response).to redirect_to(admin_articles_path)
    end
  end
end
