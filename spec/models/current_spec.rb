require 'rails_helper'

RSpec.describe Current, type: :model do
  it 'sets and retrieves the user attribute' do
    user = User.new
    Current.user = user
    expect(Current.user).to eq(user)
  end
end
