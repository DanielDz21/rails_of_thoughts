require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'password' do
    it 'validates its presence' do
      user = User.new

      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  describe 'email' do
    it 'validates its presence' do
      user = User.new

      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates its uniqueness' do
      User.create(email: 'john@doe.com', password: 'password')
      user2 = User.new(email: 'john@doe.com', password: 'password')

      user2.valid?
      expect(user2.errors[:email]).to include('has already been taken')
    end

    it 'normalizes its value with downcase' do
      user = User.create(email: 'John@Doe.com', password: 'password')

      expect(user.email).to eq('john@doe.com')
    end
  end
end
