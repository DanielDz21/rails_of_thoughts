require 'factory_bot'

FactoryBot.define do
  factory :article do
    title { 'Default title' }
    content { 'Default content' }
  end
end
