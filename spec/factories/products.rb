# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    price { rand 1..1000 }
    old_price { 1..1000 }
    status { 0 }
    quantity { rand 1..100 }
    active { true }
    poster do
      Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/test.jpg'), 'image/jpeg')
    end
  end
end
