require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'validates presence of title' do
    article = Article.new(title: nil)

    article.valid?
    expect(article.errors[:title]).to include("can't be blank")
  end

  it 'has rich text content' do
    expect(Article.new).to respond_to(:content)
  end
end
