require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    it 'returns all articles' do
      articles = FactoryBot.create_list(:article, 2)

      get :index
      expect(assigns(:articles)).to eq(articles)
    end
  end

  describe 'GET #show' do
    it 'returns the requested article' do
      article = FactoryBot.create(:article)

      get :show, params: { id: article.id }
      expect(assigns(:article)).to eq(article)
    end
  end
end
