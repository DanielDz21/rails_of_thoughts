require 'factory_bot'

FactoryBot.define do
  factory :user do
    email { 'john@doe.com' }
    password { 'admin123' }
    password_confirmation { 'admin123' }
  end
end
