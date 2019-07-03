# frozen_string_literal: true

FactoryBot.define do
  unless FactoryBot.sequences.registered?(:email)
    sequence :email do |n|
      "user#{n}@example.com"
    end
  end

  unless FactoryBot.factories.registered?(:user)
    factory :user do
      email
      password { 'password' }
    end
  end
end
