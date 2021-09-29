# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    name { Faker::Lorem.word }
    email { Faker::Internet.unique.email }
  end
end
